import 'package:drift/drift.dart';

/// Tabela de músicas adicionadas pelo usuário.
/// A letra original fica salva exclusivamente no aparelho.
class SongsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get artist => text().withLength(min: 1, max: 200)();
  TextColumn get fullLyrics => text()(); // Salva somente localmente
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
