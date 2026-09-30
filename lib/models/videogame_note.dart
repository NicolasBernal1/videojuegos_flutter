class VideoGameNote {
  final int videoGameId;
  final String note;
  final int rating;
  final DateTime updatedAt;

  const VideoGameNote({
    required this.videoGameId,
    required this.note,
    required this.rating,
    required this.updatedAt
  });

  factory VideoGameNote.fromJson(Map<String,dynamic> json) {
    return VideoGameNote(
    videoGameId: json['videogame_id'] as int, 
    note: json['note'], 
    rating: json['rating'] as int, 
    updatedAt: DateTime.parse(json['updated_at'])
    );
  }

  Map<String,dynamic> toJson() => {
    'videogame_id':videoGameId,
    'note':note,
    'rating':rating,
    'updated_at':updatedAt.toIso8601String()
  };
}