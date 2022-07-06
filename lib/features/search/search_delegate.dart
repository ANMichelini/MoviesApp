import 'package:flutter/material.dart';
import 'package:peliculasdos/features/home/models/movie_model.dart';
import 'package:peliculasdos/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/movie_item_widget.dart';

class MovieSearchDelegate extends SearchDelegate {
  final String route;

  MovieSearchDelegate(this.route);
  @override
  String get searchFieldLabel => 'Search movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();
        final movies = snapshot.data!;
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (_, int index) => MovieItem(movies[index], route),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();
        final movies = snapshot.data!;
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (_, int index) => MovieItem(movies[index], route),
        );
      },
    );
  }
}

Widget _emptyContainer() {
  return const Center(
    child: Icon(
      Icons.movie_creation_outlined,
      color: Colors.black38,
      size: 130,
    ),
  );
}
