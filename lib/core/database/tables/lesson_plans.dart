import 'package:drift/drift.dart';
import 'songs.dart';

/// Tabela de plano de aula por dias gerado pela IA.
class LessonPlansTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get songId => integer().references(SongsTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get totalDays => integer()();
  TextColumn get planJson => text()(); // Estrutura em JSON dos dias e seções
  IntColumn get currentDay => integer().withDefault(const Constant(1))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
