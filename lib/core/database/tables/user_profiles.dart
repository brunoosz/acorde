import 'package:drift/drift.dart';

/// Tabela de perfil do usuário.
/// Armazena respostas do questionário rápido (0 a 10, objetivo, gosto musical, etc.).
/// Fica salva exclusivamente no aparelho.
class UserProfileTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get objective => text().withLength(min: 1, max: 500)();
  IntColumn get spanishLevel => integer()(); // 0 a 10
  IntColumn get dailyMinutes => integer()(); // Ex: 10, 15, 20
  TextColumn get currentKnowledge => text()();
  TextColumn get musicPreferences => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
