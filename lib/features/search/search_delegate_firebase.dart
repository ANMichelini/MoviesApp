import 'package:peliculasdos/models/models.dart';
import 'package:peliculasdos/features/user_collection/repository/movie_firebase_repository.dart';

class MovieSearchFirebaseDelegate extends SearchDelegate {
  final String route;

  MovieSearchFirebaseDelegate(this.route);
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
    MovieFirebaseRepository moviesFirebaseProvider = MovieFirebaseRepository();
    moviesFirebaseProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesFirebaseProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<MovieFirebaseModel>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();
        final movies = snapshot.data!;
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItem(movies[index], route),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    MovieFirebaseRepository moviesFirebaseProvider = MovieFirebaseRepository();
    moviesFirebaseProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesFirebaseProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<MovieFirebaseModel>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();
        final movies = snapshot.data!;
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItem(movies[index], route),
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

class _MovieItem extends StatelessWidget {
  final MovieFirebaseModel movieFirebase;
  final String route;
  const _MovieItem(this.movieFirebase, this.route);

  @override
  Widget build(BuildContext context) {
    movieFirebase.heroid = 'search${movieFirebase.id}';
    return ListTile(
        leading: Hero(
          tag: movieFirebase.heroid!,
          child: FadeInImage(
            fadeOutDuration: const Duration(milliseconds: 200),
            placeholder: const AssetImage('assets/loadingmovie.gif'),
            image: NetworkImage(movieFirebase.fullPosterImg),
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(movieFirebase.title!),
        subtitle: Row(
          children: [
            const Icon(Icons.star_border, size: 10),
            const SizedBox(width: 2),
            Text(movieFirebase.voteaverage.toString()),
          ],
        ),
        onTap: () {
          Navigator.pushReplacementNamed(context, route,
              arguments: movieFirebase);
        });
  }
}
