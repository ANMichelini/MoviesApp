import 'dart:async';

import 'package:http/http.dart' as http;

import '../../../models/models.dart';

class MoviesRepository {
  MoviesRepository();

  final String _baseUrl = 'api.themoviedb.org';

  final String _apiKey = '70a6f0e44913f5596b834e1ce9229894';
  final String _language = 'en-USA';

  int _popularPage = 0;
  int _upcomingPage = 0;
  int _topRatedPage = 0;

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final response = await http.get(url);
    return response.body;
  }

  Future<List<Movie>> getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingModel.fromJson(jsonData);
    return nowPlayingResponse.results;
  }

  Future<List<Movie>> getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularModel.fromJson(jsonData);
    return popularResponse.results;
  }

  Future<List<Movie>> getUpcomingMovies() async {
    _upcomingPage++;
    final jsonData = await _getJsonData('3/movie/upcoming', _upcomingPage);
    final upcomingResponse = UpcomingModel.fromJson(jsonData);
    return upcomingResponse.results;
  }

  Future<List<Movie>> getTopRatedMovies() async {
    _topRatedPage++;
    final jsonData = await _getJsonData('3/movie/top_rated', _topRatedPage);
    final topRatedResponse = TopRatedModel.fromJson(jsonData);
    return topRatedResponse.results;
  }

  Future<List<Cast>> getMovieCast(
      int movieId, Map<int, List<Cast>> moviesCast) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final castResponse = CastModel.fromJson(jsonData);
    moviesCast[movieId] = castResponse.cast;
    return castResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});
    final response = await http.get(url);
    final searchResponse = SearchModel.fromJson(response.body);

    return searchResponse.results;
  }
}
