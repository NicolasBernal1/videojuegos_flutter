import 'package:drift/drift.dart';

@DataClassName('VideogameNoteRow')
class VideoGameNotes extends Table {
  IntColumn get videoGameId => integer()();
  TextColumn get note => text()();
  IntColumn get rating => integer()();
  DateTimeColumn get updatedAt => dateTime()();

  BoolColumn get pendingSync => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {videoGameId};
}