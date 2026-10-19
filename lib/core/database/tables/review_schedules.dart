import 'package:drift/drift.dart';
import 'vocabularies.dart';

/// Agendamento de revisão espaçada simples (1 dia -> 3 dias -> 7 dias -> 14 dias).
/// Acerto: nível + 1 (máx 4).
/// Erro: volta para o nível 1 (1 dia).
class ReviewScheduleTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vocabId => integer().unique().references(VocabularyTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get level => integer().withDefault(const Constant(1))(); // 1, 2, 3, 4
  DateTimeColumn get nextReviewAt => dateTime()();
  DateTimeColumn get lastReviewedAt => dateTime().nullable()();
  IntColumn get reviewCount => integer().withDefault(const Constant(0))();
}
