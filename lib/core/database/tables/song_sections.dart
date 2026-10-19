import 'package:drift/drift.dart';
import 'songs.dart';

/// Tabela de seções da música (divididas pela IA ou pelo usuário).
class SongSectionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get songId => integer().references(SongsTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get sectionOrder => integer()();
  TextColumn get label => text().withLength(min: 1, max: 100)(); // Ex: "Estrofe 1", "Refrão"
  TextColumn get textContent => text()();
}
