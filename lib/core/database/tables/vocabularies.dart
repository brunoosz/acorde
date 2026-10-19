import 'package:drift/drift.dart';
import 'songs.dart';

/// Palavras salvas pelo usuário durante as aulas para memorização.
class VocabularyTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get songId => integer().nullable().references(SongsTable, #id, onDelete: KeyAction.setNull)();
  TextColumn get word => text().withLength(min: 1, max: 200)();
  TextColumn get translation => text().withLength(min: 1, max: 300)();
  TextColumn get exampleSentence => text()();
  TextColumn get origin => text().withLength(min: 1, max: 200)(); // Ex: nome da música, "Gíria / Lunfardo"
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
