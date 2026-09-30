import 'package:flutter/material.dart';
import 'package:videogames/models/videogame.dart';

class VideoGameCard extends StatelessWidget {
  final VideoGame videogame;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const VideoGameCard({
    super.key,
    required this.videogame,
    required this.onTap,
    required this.onFavoriteTap,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      color: isFavorite ? colors.primaryContainer : colors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  videogame.imagePath,
                  width: 72,
                  height: 108,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 72,
                      height: 108,
                      color: colors.surfaceContainerHighest,
                      child: const Icon(Icons.gamepad_outlined, size: 32),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      videogame.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isFavorite
                            ? colors.onPrimaryContainer
                            : colors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      videogame.genre,
                      style: TextStyle(color: colors.onSurfaceVariant),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          videogame.played
                              ? Icons.check_circle_outline
                              : Icons.schedule,
                          size: 16,
                          color: colors.primary,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(videogame.played ? 'Completado' : 'Pendiente'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: isFavorite
                    ? 'Quitar favorita'
                    : 'Marcar como favorita',
                onPressed: onFavoriteTap,
                icon: Icon(isFavorite ? Icons.star : Icons.star_border),
                color: colors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
