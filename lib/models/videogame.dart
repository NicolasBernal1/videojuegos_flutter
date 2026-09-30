
class VideoGame {
  final int id;
  final String title;
  final String genre;
  final bool played;
  final String description;
  final String imagePath;

  VideoGame({
    required this.id,
    required this.title,
    required this.genre,
    required this.played,
    required this.description,
    required this.imagePath
  });

  factory VideoGame.fromJson(Map<String,dynamic> json) {
    return VideoGame(
    id: json['id'],
    title: json['title'],
    genre: json['genre'], 
    played: json['played'], 
    description: json['description'], 
    imagePath: json['imagePath']
    );
  }
}
