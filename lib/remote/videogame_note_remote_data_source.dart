import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:videogames/models/videogame_note.dart';

class VideogameNoteRemoteDataSource {
  final FirebaseFirestore firestore;

  VideogameNoteRemoteDataSource(this.firestore);

  Future<void> upsertNote(VideoGameNote note) async {
    await firestore
        .collection('videogame_notes')
        .doc(note.videoGameId.toString())
        .set(note.toJson());
  }
}
