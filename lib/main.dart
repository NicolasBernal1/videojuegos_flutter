import 'package:flutter/material.dart';
import 'videogame_screen.dart';

void main() {
  // Punto de entrada de la aplicacion.
  // runApp le entrega a Flutter el widget raiz.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const VideoGameScreen(),
    );
  }
}
