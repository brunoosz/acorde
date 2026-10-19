import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../domain/models/song.dart';
import '../../../lesson/domain/models/lesson_plan.dart';

final musicRepositoryProvider = Provider<MusicRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return MusicRepository(db);
});

class MusicRepository {
  final AppDatabase _db;

  MusicRepository(this._db);

  /// Salva a música, suas seções divididas pela IA e o plano de aulas
  Future<int> insertSongWithSectionsAndPlan({
    required String title,
    required String artist,
    required String fullLyrics,
    required int totalDays,
    required String planJson,
    required List<Map<String, dynamic>> sections,
    String? audioPath,
  }) async {
    return _db.transaction(() async {
      // 1. Inserir música
      final songResult = await _db.customInsert(
        'INSERT INTO songs_table (title, artist, full_lyrics, audio_path, created_at) VALUES (?, ?, ?, ?, ?)',
        variables: [
          Variable.withString(title),
          Variable.withString(artist),
          Variable.withString(fullLyrics),
          audioPath != null ? Variable.withString(audioPath) : const Variable(null),
          Variable.withString(DateTime.now().toIso8601String()),
        ],
      );

      final songId = songResult;

      // 2. Inserir seções
      for (int i = 0; i < sections.length; i++) {
        final sec = sections[i];
        await _db.customInsert(
          'INSERT INTO song_sections_table (song_id, section_order, label, text_content) VALUES (?, ?, ?, ?)',
          variables: [
            Variable.withInt(songId),
            Variable.withInt(sec['id'] as int? ?? (i + 1)),
            Variable.withString(sec['label'] as String? ?? 'Seção ${i + 1}'),
            Variable.withString(sec['text'] as String? ?? ''),
          ],
        );
      }

      // 3. Inserir plano de aula
      await _db.customInsert(
        'INSERT INTO lesson_plans_table (song_id, total_days, plan_json, current_day, is_completed, created_at) VALUES (?, ?, ?, ?, ?, ?)',
        variables: [
          Variable.withInt(songId),
          Variable.withInt(totalDays),
          Variable.withString(planJson),
          Variable.withInt(1),
          Variable.withBool(false),
          Variable.withString(DateTime.now().toIso8601String()),
        ],
      );

      return songId;
    });
  }

  /// Lista todas as músicas cadastradas
  Future<List<Song>> getAllSongs() async {
    final rows = await _db.customSelect(
      'SELECT id, title, artist, full_lyrics, audio_path, created_at FROM songs_table ORDER BY id DESC',
    ).get();

    return rows.map((row) {
      return Song(
        id: row.read<int>('id'),
        title: row.read<String>('title'),
        artist: row.read<String>('artist'),
        fullLyrics: row.read<String>('full_lyrics'),
        audioPath: row.readNullable<String>('audio_path'),
        createdAt: DateTime.tryParse(row.read<String>('created_at')) ?? DateTime.now(),
      );
    }).toList();
  }

  /// Busca os detalhes de uma música pelo ID
  Future<Song?> getSong(int id) async {
    final row = await _db.customSelect(
      'SELECT id, title, artist, full_lyrics, audio_path, created_at FROM songs_table WHERE id = ? LIMIT 1',
      variables: [Variable.withInt(id)],
    ).getSingleOrNull();

    if (row == null) return null;

    return Song(
      id: row.read<int>('id'),
      title: row.read<String>('title'),
      artist: row.read<String>('artist'),
      fullLyrics: row.read<String>('full_lyrics'),
      audioPath: row.readNullable<String>('audio_path'),
      createdAt: DateTime.tryParse(row.read<String>('created_at')) ?? DateTime.now(),
    );
  }

  /// Busca o plano de aula de uma música
  Future<LessonPlan?> getLessonPlan(int songId) async {
    final row = await _db.customSelect(
      'SELECT id, song_id, total_days, current_day, is_completed, plan_json FROM lesson_plans_table WHERE song_id = ? LIMIT 1',
      variables: [Variable.withInt(songId)],
    ).getSingleOrNull();

    if (row == null) return null;

    return LessonPlan.fromRaw(
      id: row.read<int>('id'),
      songId: row.read<int>('song_id'),
      totalDays: row.read<int>('total_days'),
      currentDay: row.read<int>('current_day'),
      isCompleted: row.read<bool>('is_completed'),
      planJson: row.read<String>('plan_json'),
    );
  }

  /// Busca as seções de uma música
  Future<List<SongSection>> getSongSections(int songId) async {
    final rows = await _db.customSelect(
      'SELECT id, song_id, section_order, label, text_content FROM song_sections_table WHERE song_id = ? ORDER BY section_order ASC',
      variables: [Variable.withInt(songId)],
    ).get();

    return rows.map((row) {
      return SongSection(
        id: row.read<int>('id'),
        songId: row.read<int>('song_id'),
        sectionOrder: row.read<int>('section_order'),
        label: row.read<String>('label'),
        textContent: row.read<String>('text_content'),
      );
    }).toList();
  }

  /// Atualiza o caminho do áudio de uma música
  Future<void> updateSongAudio(int songId, String? audioPath) async {
    await _db.customUpdate(
      'UPDATE songs_table SET audio_path = ? WHERE id = ?',
      variables: [
        audioPath != null ? Variable.withString(audioPath) : const Variable(null),
        Variable.withInt(songId),
      ],
    );
  }

  /// Atualiza o progresso do dia atual
  Future<void> updatePlanProgress(int songId, int nextDay, bool isCompleted) async {
    await _db.customUpdate(
      'UPDATE lesson_plans_table SET current_day = ?, is_completed = ? WHERE song_id = ?',
      variables: [
        Variable.withInt(nextDay),
        Variable.withBool(isCompleted),
        Variable.withInt(songId),
      ],
    );
  }
}
