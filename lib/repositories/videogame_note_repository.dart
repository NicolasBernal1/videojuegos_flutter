import 'package:videogames/local/videogame_note_local_data_source.dart';
import 'package:videogames/models/videogame_note.dart';
import 'package:videogames/remote/videogame_note_remote_data_source.dart';

class VideogameNoteRepository {
  final VideogameNoteLocalDataSource local;
  final VideogameNoteRemoteDataSource? remote;

  VideogameNoteRepository({ required this.local, this.remote });

  Future<VideoGameNote?> getNoteForVideogame(int videogameId) => 
    local.getNoteForVideoGame(videogameId);

  Future<void> saveNote(VideoGameNote note) async {
    await local.saveNote(note);

    final remoteSource = remote;
    if(remoteSource == null) return;

    try {
      await remoteSource.upsertNote(note);
      await local.markSynced(note.videoGameId);
    } catch (_) {

    }
  }

  Future<void> syncPending() async {
    final remoteSource = remote;
    if(remoteSource == null) return;

    final pending = await local.getPendingNotes();

    for(final note in pending){
      try {
        await remoteSource.upsertNote(note);
        await local.markSynced(note.videoGameId);
      } catch (_) {
        
      }
    }
  }
}