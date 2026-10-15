import 'package:videogames/local/app_database.dart';
import 'package:videogames/models/videogame_note.dart';
import 'package:drift/drift.dart';

class VideogameNoteLocalDataSource {
  final AppDatabase db;

  VideogameNoteLocalDataSource(this.db);

  VideoGameNote _toDomain(VideogameNoteRow row) {
    return VideoGameNote(
      videoGameId: row.videoGameId,
      note: row.note,
      rating: row.rating,
      updatedAt: row.updatedAt,
    );
  }

  Future<VideoGameNote?> getNoteForVideoGame(int videogameId) async {
    final query = db.select(db.videoGameNotes)
      ..where((t) => t.videoGameId.equals(videogameId));
    final row = await query.getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  Future<void> saveNote(VideoGameNote note) async {
    await db
        .into(db.videoGameNotes)
        .insertOnConflictUpdate(
          VideoGameNotesCompanion.insert(
            videoGameId: Value(note.videoGameId),
            note: note.note,
            rating: note.rating,
            updatedAt: note.updatedAt,
            pendingSync: const Value(true),
          ),
        );
  }

  Future<List<VideoGameNote>> getPendingNotes() async {
    final rows = await (db.select(
      db.videoGameNotes,
    )..where((t) => t.pendingSync.equals(true))).get();

    return rows.map(_toDomain).toList();
  }

  Future<void> markSynced(int videogameId) async {
    await (db.update(db.videoGameNotes)
          ..where((t) => t.videoGameId.equals(videogameId)))
        .write(const VideoGameNotesCompanion(pendingSync: Value(false)));
  }
}
