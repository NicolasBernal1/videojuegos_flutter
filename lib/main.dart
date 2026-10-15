import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:videogames/firebase_options.dart';
import 'package:videogames/local/app_database.dart';
import 'package:videogames/local/videogame_note_local_data_source.dart';
import 'package:videogames/remote/videogame_note_remote_data_source.dart';
import 'package:videogames/repositories/videogame_note_repository.dart';
import 'videogame_screen.dart';

void main() async {
  // Punto de entrada de la aplicacion.
  // runApp le entrega a Flutter el widget raiz.

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  final database = AppDatabase();
  final local = VideogameNoteLocalDataSource(database);
  final remote = VideogameNoteRemoteDataSource(FirebaseFirestore.instance);
  final noteRepository = VideogameNoteRepository(local: local, remote: remote);

  runApp(MyApp(noteRepository: noteRepository));
}

class MyApp extends StatelessWidget {
  final VideogameNoteRepository noteRepository;

  const MyApp({super.key, required this.noteRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: VideoGameScreen(noteRepository: noteRepository),
    );
  }
}
