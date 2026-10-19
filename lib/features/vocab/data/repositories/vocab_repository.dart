import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';

class ReviewItem {
  final int vocabId;
  final String word;
  final String translation;
  final String example;
  final String origin;
  final int level;
  final DateTime nextReviewAt;
  final int reviewCount;

  const ReviewItem({
    required this.vocabId,
    required this.word,
    required this.translation,
    required this.example,
    required this.origin,
    required this.level,
    required this.nextReviewAt,
    required this.reviewCount,
  });

  bool get isDueToday => nextReviewAt.isBefore(DateTime.now());
}

final vocabRepositoryProvider = Provider<VocabRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return VocabRepository(db);
});

class VocabRepository {
  final AppDatabase _db;

  VocabRepository(this._db);

  /// Retorna as palavras pendentes de revisão hoje ou atrasadas
  Future<List<ReviewItem>> getDueReviews() async {
    final nowIso = DateTime.now().toIso8601String();

    final rows = await _db.customSelect(
      '''
      SELECT v.id as vocab_id, v.word, v.translation, v.example_sentence, v.origin,
             r.level, r.next_review_at, r.review_count
      FROM vocabulary_table v
      INNER JOIN review_schedule_table r ON v.id = r.vocab_id
      WHERE r.next_review_at <= ?
      ORDER BY r.next_review_at ASC
      ''',
      variables: [Variable.withString(nowIso)],
    ).get();

    return rows.map((row) {
      return ReviewItem(
        vocabId: row.read<int>('vocab_id'),
        word: row.read<String>('word'),
        translation: row.read<String>('translation'),
        example: row.read<String>('example_sentence'),
        origin: row.read<String>('origin'),
        level: row.read<int>('level'),
        nextReviewAt: DateTime.tryParse(row.read<String>('next_review_at')) ?? DateTime.now(),
        reviewCount: row.read<int>('review_count'),
      );
    }).toList();
  }

  /// Retorna todas as palavras salvas no banco
  Future<List<ReviewItem>> getAllVocab() async {
    final rows = await _db.customSelect(
      '''
      SELECT v.id as vocab_id, v.word, v.translation, v.example_sentence, v.origin,
             r.level, r.next_review_at, r.review_count
      FROM vocabulary_table v
      LEFT JOIN review_schedule_table r ON v.id = r.vocab_id
      ORDER BY v.id DESC
      ''',
    ).get();

    return rows.map((row) {
      return ReviewItem(
        vocabId: row.read<int>('vocab_id'),
        word: row.read<String>('word'),
        translation: row.read<String>('translation'),
        example: row.read<String>('example_sentence'),
        origin: row.read<String>('origin'),
        level: row.read<int?>('level') ?? 1,
        nextReviewAt: DateTime.tryParse(row.read<String?>('next_review_at') ?? '') ?? DateTime.now(),
        reviewCount: row.read<int?>('review_count') ?? 0,
      );
    }).toList();
  }

  /// Registra o resultado da revisão
  Future<void> answerReview({required int vocabId, required bool wasCorrect}) async {
    await _db.recordReviewResult(vocabId: vocabId, wasCorrect: wasCorrect);
  }
}
