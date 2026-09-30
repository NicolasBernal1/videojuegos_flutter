import 'dart:async';
import 'dart:convert';

import 'package:videogames/models/videogame.dart';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => message;
}

class VideoGameService {
  final String baseUrl;

  VideoGameService(this.baseUrl);

  Future<List<VideoGame>> getVideoGames() async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data.map((item) => VideoGame.fromJson(item)).toList();
      }

      if (response.statusCode == 404) {
        throw const ApiException("Couldn't find videogames");
      }

      if (response.statusCode == 500) {
        throw const ApiException("Server does not exist");
      }
      throw ApiException('Error HTTP ${response.statusCode}');
    } on TimeoutException {
      throw const ApiException('The server took too much time to response');
    }
  }
}
