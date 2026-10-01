import 'package:flutter/material.dart';
import 'package:videogames/videogame_card.dart';
import 'package:videogames/videogame_detail.dart';
import 'package:videogames/services/videogame_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/videogame.dart';

class VideoGameScreen extends StatefulWidget {
  const VideoGameScreen({super.key});

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

  void retryVideoGameList(){
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
      MaterialPageRoute(builder: (_) => VideoGameDetailPage(videogame: videoGame)),
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
      appBar: AppBar(title: const Text('Mis videojuegos'), centerTitle: true),
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
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_off_outlined, size: 48),
                  const SizedBox(height: 16),
                  const Text(
                    'No pudimos cargar los videojuegos',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: retryVideoGameList,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          );
        }

        final videoGames = snapshot.data ?? [];

        if (videoGames.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.gamepad_outlined, size: 48),
                  SizedBox(height: 16),
                  Text(
                    'Todavía no hay videojuegos disponibles',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
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
