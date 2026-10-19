import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/user_profiles.dart';
import 'tables/songs.dart';
import 'tables/song_sections.dart';
import 'tables/lesson_plans.dart';
import 'tables/lesson_contents.dart';
import 'tables/vocabularies.dart';
import 'tables/review_schedules.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  UserProfileTable,
  SongsTable,
  SongSectionsTable,
  LessonPlansTable,
  LessonContentTable,
  VocabularyTable,
  ReviewScheduleTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.connection);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          // Habilita chaves estrangeiras no SQLite
          await customStatement('PRAGMA foreign_keys = ON;');
        },
      );

  // -------------------------------------------------------------
  // SEGURANÇA E PRIVACIDADE: Apagar todos os dados
  // -------------------------------------------------------------
  Future<void> deleteAllUserData() async {
    await transaction(() async {
      await customStatement('PRAGMA foreign_keys = OFF;');
      await delete(reviewScheduleTable).go();
      await delete(vocabularyTable).go();
      await delete(lessonContentTable).go();
      await delete(lessonPlansTable).go();
      await delete(songSectionsTable).go();
      await delete(songsTable).go();
      await delete(userProfileTable).go();
      await customStatement('PRAGMA foreign_keys = ON;');
    });
  }

  // -------------------------------------------------------------
  // REVISÃO ESPAÇADA SIMPLES (1 dia -> 3 dias -> 7 dias -> 14 dias)
  // -------------------------------------------------------------
  static const Map<int, int> reviewIntervalsInDays = {
    1: 1,
    2: 3,
    3: 7,
    4: 14,
  };

  /// Salva uma nova palavra e cria o primeiro agendamento para daqui a 1 dia.
  Future<int> saveWordWithInitialReview({
    required String word,
    required String translation,
    required String exampleSentence,
    required String origin,
    int? songId,
  }) async {
    return transaction(() async {
      final vocabId = await into(vocabularyTable).insert(
        VocabularyTableCompanion.insert(
          word: word,
          translation: translation,
          exampleSentence: exampleSentence,
          origin: origin,
          songId: Value(songId),
        ),
      );

      final nextDate = DateTime.now().add(const Duration(days: 1));
      await into(reviewScheduleTable).insert(
        ReviewScheduleTableCompanion.insert(
          vocabId: vocabId,
          level: const Value(1),
          nextReviewAt: nextDate,
        ),
      );

      return vocabId;
    });
  }

  /// Registra o resultado da revisão de uma palavra:
  /// - Acertou: avança nível (1->2->3->4), próximo intervalo em 1, 3, 7 ou 14 dias.
  /// - Errou: volta para o nível 1 (1 dia).
  Future<void> recordReviewResult({
    required int vocabId,
    required bool wasCorrect,
  }) async {
    final schedule = await (select(reviewScheduleTable)..where((tbl) => tbl.vocabId.equals(vocabId)))
        .getSingleOrNull();

    if (schedule == null) return;

    final int nextLevel;
    final int daysToAdd;

    if (wasCorrect) {
      nextLevel = (schedule.level >= 4) ? 4 : schedule.level + 1;
      daysToAdd = reviewIntervalsInDays[nextLevel] ?? 14;
    } else {
      nextLevel = 1;
      daysToAdd = 1;
    }

    final nextReviewDate = DateTime.now().add(Duration(days: daysToAdd));

    await (update(reviewScheduleTable)..where((tbl) => tbl.vocabId.equals(vocabId))).write(
      ReviewScheduleTableCompanion(
        level: Value(nextLevel),
        nextReviewAt: Value(nextReviewDate),
        lastReviewedAt: Value(DateTime.now()),
        reviewCount: Value(schedule.reviewCount + 1),
      ),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'acorde.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
