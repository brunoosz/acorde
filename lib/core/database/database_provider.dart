import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_database.dart';

/// Provedor global da instância única do banco de dados Drift.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(() => database.close());
  return database;
});
