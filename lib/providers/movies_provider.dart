import 'dart:async';

import 'package:peliculasdos/features/home/repositories/movie_repository.dart';
import 'package:peliculasdos/helpers/debouncer.dart';
import 'package:peliculasdos/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  MoviesProvider() {
    fetchOnDisplayMovies();
    fetchPopularMovies();
    fetchUpcomingMovies();
    fetchTopRatedMovies();
  }

  Map<int, List<Cast>> moviesCast = {};
  var onDisplayMovies = <Movie>[];
  var popularMovies = <Movie>[];
  var upcomingMovies = <Movie>[];
  var topRatedMovies = <Movie>[];
  var movieCastList = <Cast>[];
  final MoviesRepository _moviesRepo = MoviesRepository();

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionsStreamController =
      StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream =>
      _suggestionsStreamController.stream;

  Future<List<Movie>> fetchOnDisplayMovies() async {
    final onDisplay = await _moviesRepo.getOnDisplayMovies();
    onDisplayMovies = onDisplay;
    notifyListeners();
    return onDisplayMovies;
  }

  Future<List<Movie>> fetchPopularMovies() async {
    final popular = await _moviesRepo.getPopularMovies();
    popularMovies = [...popularMovies, ...popular];
    notifyListeners();
    return popularMovies;
  }

  Future<List<Movie>> fetchUpcomingMovies() async {
    final upcoming = await _moviesRepo.getUpcomingMovies();
    upcomingMovies = [...upcomingMovies, ...upcoming];
    notifyListeners();
    return upcomingMovies;
  }

  Future<List<Movie>> fetchTopRatedMovies() async {
    final topRated = await _moviesRepo.getTopRatedMovies();
    topRatedMovies = [...topRatedMovies, ...topRated];
    notifyListeners();
    return topRatedMovies;
  }

  Future<List<Cast>> fetchMovieCast(int movieId) async {
    movieCastList = await _moviesRepo.getMovieCast(movieId, moviesCast);
    notifyListeners();
    return movieCastList;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await _moviesRepo.searchMovies(value);
      _suggestionsStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 51))
        .then((_) => timer.cancel());
  }
}
