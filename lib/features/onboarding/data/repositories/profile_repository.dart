import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../domain/models/user_profile.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ProfileRepository(db);
});

class ProfileRepository {
  final AppDatabase _db;

  ProfileRepository(this._db);

  /// Recupera o perfil único do usuário, se já preenchido
  Future<UserProfile?> getProfile() async {
    final query = await _db.customSelect(
      'SELECT id, objective, spanish_level, daily_minutes, current_knowledge, music_preferences, created_at FROM user_profile_table ORDER BY id ASC LIMIT 1',
    ).getSingleOrNull();

    if (query == null) return null;

    return UserProfile(
      id: query.read<int>('id'),
      objective: query.read<String>('objective'),
      spanishLevel: query.read<int>('spanish_level'),
      dailyMinutes: query.read<int>('daily_minutes'),
      currentKnowledge: query.read<String>('current_knowledge'),
      musicPreferences: query.read<String>('music_preferences'),
      createdAt: DateTime.tryParse(query.read<String>('created_at')) ?? DateTime.now(),
    );
  }

  /// Verifica se o usuário já completou o questionário inicial
  Future<bool> hasProfile() async {
    final profile = await getProfile();
    return profile != null;
  }

  /// Salva ou atualiza as respostas do questionário
  Future<void> saveProfile({
    required String objective,
    required int spanishLevel,
    required int dailyMinutes,
    required String currentKnowledge,
    required String musicPreferences,
  }) async {
    final existing = await getProfile();

    if (existing == null) {
      await _db.customInsert(
        'INSERT INTO user_profile_table (objective, spanish_level, daily_minutes, current_knowledge, music_preferences, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?)',
        variables: [
          Variable.withString(objective),
          Variable.withInt(spanishLevel),
          Variable.withInt(dailyMinutes),
          Variable.withString(currentKnowledge),
          Variable.withString(musicPreferences),
          Variable.withString(DateTime.now().toIso8601String()),
          Variable.withString(DateTime.now().toIso8601String()),
        ],
      );
    } else {
      await _db.customUpdate(
        'UPDATE user_profile_table SET objective = ?, spanish_level = ?, daily_minutes = ?, current_knowledge = ?, music_preferences = ?, updated_at = ? WHERE id = ?',
        variables: [
          Variable.withString(objective),
          Variable.withInt(spanishLevel),
          Variable.withInt(dailyMinutes),
          Variable.withString(currentKnowledge),
          Variable.withString(musicPreferences),
          Variable.withString(DateTime.now().toIso8601String()),
          Variable.withInt(existing.id),
        ],
      );
    }
  }
}
