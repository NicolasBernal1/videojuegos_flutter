import 'dart:convert';
import 'dart:io';

import 'package:videogames/models/videogame_note.dart';
import 'package:path_provider/path_provider.dart';

class VideoGameNoteStorage {
  static const _fileName = 'videogame_notes.json';

  // to get the specific file
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  Future<List<VideoGameNote>> _readAll() async {
    final file = await _getFile();
    if (!await file.exists()) return [];

    final content = await file.readAsString();
    if (content.isEmpty) return [];

    final List<dynamic> data = jsonDecode(content);
    return data.map((item) => VideoGameNote.fromJson(item)).toList();
  }

  Future<void> _writeAll(List<VideoGameNote> notes) async {
    final file = await _getFile();
    final jsonString = jsonEncode(notes.map((note) => note.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  Future<VideoGameNote?> getNoteForVideoGame(int videoGameId) async {
    final notes = await _readAll();
    return notes.where((n) => n.videoGameId == videoGameId).firstOrNull;
  }

  Future<void> saveNote(VideoGameNote note)async {
    final notes = await _readAll();

    notes.removeWhere((item) => item.videoGameId == note.videoGameId);
    notes.add(note);

    await _writeAll(notes);
  }
}
