import 'package:flutter/material.dart';
import 'package:videogames/repositories/videogame_note_repository.dart';
import 'package:videogames/videogame_card.dart';
import 'package:videogames/videogame_detail.dart';
import 'package:videogames/services/videogame_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videogames/widgets/empty_view.dart';
import 'package:videogames/widgets/error_view.dart';
import 'package:videogames/widgets/loading_view.dart';
import 'models/videogame.dart';

class VideoGameScreen extends StatefulWidget {
  final VideogameNoteRepository noteRepository;
  const VideoGameScreen({super.key, required this.noteRepository});

  @override
  State<VideoGameScreen> createState() => _VideoGameScreenState();
}

class _VideoGameScreenState extends State<VideoGameScreen> {
  // -----------------------------
  // ESTADO DE LA PANTALLA
  // -----------------------------

  int? favoriteId;

  late final VideoGameService _service;
  late Future<List<VideoGame>> _futureVideoGames;

  // -----------------------------
  // CICLO DE VIDA
  // -----------------------------

  void retryVideoGameList() {
    setState(() {
      _futureVideoGames = _service.getVideoGames();
    });
  }

  Future<void> saveFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    if (favoriteId == null) {
      await prefs.remove('favoriteId');
    } else {
      await prefs.setInt('favoriteId', favoriteId!);
    }
  }

  Future<void> loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      favoriteId = prefs.getInt('favoriteId');
    });
  }

  @override
  void initState() {
    super.initState();

    // En la version final cargamos automaticamente
    // cuando nace la pantalla.
    _service = VideoGameService('https://dummyjson.com/c/0c1f-cc49-47ca-b49b');
    _futureVideoGames = _service.getVideoGames();
    loadFavorite();
  }

  // -----------------------------
  // ESTRUCTURA GENERAL
  // -----------------------------

  void openVideoGameDetail(VideoGame videoGame) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VideoGameDetailPage(
          videogame: videoGame,
          noteRepository: widget.noteRepository,
        ),
      ),
    );
  }

  void toggleFavorite(int videoGameId) {
    setState(() {
      favoriteId = favoriteId == videoGameId ? null : videoGameId;
    });
    saveFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Mis videojuegos'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Sincronizar notas',
            icon: const Icon(Icons.sync),
            onPressed: () async {
              await widget.noteRepository.syncPending();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: _buildBody(),
          ),
        ),
      ),
    );
  }

  // -----------------------------
  // ESTADO -> INTERFAZ
  // -----------------------------

  Widget _buildBody() {
    return FutureBuilder<List<VideoGame>>(
      future: _futureVideoGames,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView();
        }

        if (snapshot.hasError) {
          return ErrorView(message: "No pudimos cargar videojuegos", onRetry: retryVideoGameList);
        }

        final videoGames = snapshot.data ?? [];

        if (videoGames.isEmpty) {
          return EmptyView(message: "No se encontraron videojuegos");
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          // El encabezado se desplaza junto con las tarjetas.
          itemCount: videoGames.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tu próxima videojuego',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${videoGames.length} videojuegos para explorar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Toca una tarjeta para ver más o marca tu favorita con la estrella.',
                    ),
                  ],
                ),
              );
            }
            final videoGame = videoGames[index - 1];
            final bool isFavorite = videoGame.id == favoriteId;

            return VideoGameCard(
              videogame: videoGame,
              onTap: () {
                openVideoGameDetail(videoGame);
              },
              isFavorite: isFavorite,
              onFavoriteTap: () {
                toggleFavorite(videoGame.id);
              },
            );
          },
        );
      },
    );
  }
}
