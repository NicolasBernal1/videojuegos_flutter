import 'package:flutter/material.dart';
import 'package:videogames/models/videogame.dart';
import 'package:videogames/models/videogame_note.dart';
import 'package:videogames/services/videogame_note_storage.dart';

class VideoGameDetailPage extends StatefulWidget {
  final VideoGame videogame;
  const VideoGameDetailPage({super.key, required this.videogame});
  @override
  State<VideoGameDetailPage> createState() => _VideoGameDetailPageState();
}

class _VideoGameDetailPageState extends State<VideoGameDetailPage> {
  final VideoGameNoteStorage _storage = VideoGameNoteStorage();
  final TextEditingController _noteController = TextEditingController();
  int _rating = 0;

  @override
  void initState() {
    _loadLocalNote();
    super.initState();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadLocalNote() async {
    final saved = await _storage.getNoteForVideoGame(widget.videogame.id);
    if (!mounted || saved == null) return;

    setState(() {
      _noteController.text = saved.note;
      _rating = saved.rating;
    });
  }

  Future<void> _saveLocalNote() async {
    final note = VideoGameNote(
      videoGameId: widget.videogame.id,
      note: _noteController.text.trim(),
      rating: _rating,
      updatedAt: DateTime.now(),
    );

    await _storage.saveNote(note);

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("The note is saved")));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Detalle del videojuego'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Un póster vertical, centrado y con bordes redondeados.
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 260),
                      child: Card(
                        elevation: 4,
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: AspectRatio(
                          aspectRatio: 2 / 3,
                          child: Image.asset(
                            widget.videogame.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return ColoredBox(
                                color: colors.surfaceContainerHighest,
                                child: Center(
                                  child: Icon(
                                    Icons.gamepad_outlined,
                                    size: 72,
                                    color: colors.onSurfaceVariant,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    widget.videogame.title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Wrap permite que las etiquetas bajen en pantallas pequeñas.
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        avatar: const Icon(
                          Icons.local_movies_outlined,
                          size: 18,
                        ),
                        label: Text(widget.videogame.genre),
                        side: BorderSide.none,
                        backgroundColor: colors.secondaryContainer,
                      ),
                      Chip(
                        avatar: Icon(
                          widget.videogame.played
                              ? Icons.check_circle_outline
                              : Icons.schedule,
                          size: 18,
                        ),
                        label: Text(
                          widget.videogame.played
                              ? 'Jugado'
                              : 'Pendiente por jugar',
                        ),
                        side: BorderSide.none,
                        backgroundColor: colors.surfaceContainerHighest,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Sinopsis',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.videogame.description,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text(
                    "Local Notes",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Note",
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: List.generate(5, ((index) {
                      final value = index + 1;
                      return ChoiceChip(
                        label: Text(value.toString()),
                        selected: _rating == value,
                        onSelected: (_) {
                          setState(() {
                            _rating = value;
                          });
                        },
                      );
                    })),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _saveLocalNote, 
                    child: const Text("Save Note")
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
