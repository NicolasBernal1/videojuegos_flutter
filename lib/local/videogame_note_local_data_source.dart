import 'package:videogames/local/app_database.dart';
import 'package:videogames/models/videogame_note.dart';

class VideogameNoteLocalDataSource {
  final AppDatabase db;

  VideoGameNoteLocalDataSource(this.db)

  VideoGameNote _toDomain(VideogameNoteRow row) {
    return VideoGameNote(
      videoGameId: row.videoGameId,
      note: row.note,
      rating: row.rating,
      updatedAt: row.updatedAt,
    );
  }

  Future<VideoGameNote?> getNoteForVideoGame(int videogameId) async {
    final query = db.select(db.videoGameNotes)..where((t) => t.videoGameId.equals(videogameId));
    final row = await query.getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }
}
