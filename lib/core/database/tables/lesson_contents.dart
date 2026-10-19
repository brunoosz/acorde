import 'package:drift/drift.dart';
import 'songs.dart';

/// Cache do conteúdo gerado pela IA para cada dia da música.
/// Evita novas requisições de IA para conteúdos já gerados.
class LessonContentTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get songId => integer().references(SongsTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get day => integer()();
  TextColumn get contentJson => text()(); // JSON com pronúncia, gírias, gramática, falsos amigos, vocab
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get generatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {songId, day},
      ];
}
