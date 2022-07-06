import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:peliculasdos/features/search/model/search_firebase_model.dart';
import 'package:peliculasdos/helpers/debouncer.dart';
import 'package:peliculasdos/models/models.dart';

class MovieFirebaseRepository {
  final storage = const FlutterSecureStorage();
  final String _baseUrl = 'peliculasdos-cb8d8-default-rtdb.firebaseio.com';
  var moviesFirebaseList = <MovieFirebaseModel>[];

  bool isSaving = false;
  MovieFirebaseModel movieFirebaseModel = MovieFirebaseModel();

  final String _apiKey = '70a6f0e44913f5596b834e1ce9229894';
  final String _language = 'en-USA';

  /// Loads movie from Firebase Realtime Database
  Future<List<MovieFirebaseModel>> loadMovies() async {
    final url = Uri.https(_baseUrl, 'MOVIES.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.get(url);

    if (resp.body != "null") {
      final Map<String, dynamic> moviesMap = json.decode(resp.body);

      moviesMap.forEach((key, value) {
        final movie = MovieFirebaseModel.fromJson(value);
        moviesFirebaseList.add(movie);
      });
    }

    return moviesFirebaseList;
  }

  /// Creates movie in Firebase
  Future<bool> createMovie(MovieFirebaseModel movieFirebaseModel) async {
    final url = Uri.https(_baseUrl, 'MOVIES.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.post(url, body: movieFirebaseModel.toJson());
    // ignore: unused_local_variable
    final decodedData = json.decode(resp.body);

    return true;
  }

  /// Deletes movie from Firebase depending on the id
  Future<void> deleteMovie(MovieFirebaseModel movieFirebaseModel) async {
    moviesFirebaseList
        .removeWhere((movie) => movie.id == movieFirebaseModel.id);
  }

  Future<List<MovieFirebaseModel>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});
    final response = await http.get(url);
    final searchResponse = SearchFirebaseModel.fromJson(response.body);

    return searchResponse.results;
  }

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<MovieFirebaseModel>>
      _suggestionsStreamController = StreamController.broadcast();
  Stream<List<MovieFirebaseModel>> get suggestionStream =>
      _suggestionsStreamController.stream;

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchMovies(value);
      _suggestionsStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 51))
        .then((_) => timer.cancel());
  }
}
