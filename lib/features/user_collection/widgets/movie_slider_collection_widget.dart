import 'package:flutter/cupertino.dart';
import 'package:peliculasdos/features/user_collection/models/movie_firebase_model.dart';
import 'package:peliculasdos/features/user_collection/repository/movie_firebase_repository.dart';

import 'movie_poster_firebase_widget.dart';

class MovieSliderCollection extends StatefulWidget {
  final String category;

  const MovieSliderCollection({Key? key, required this.category})
      : super(key: key);

  @override
  State<MovieSliderCollection> createState() => _MovieSliderCollectionState();
}

class _MovieSliderCollectionState extends State<MovieSliderCollection> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    MovieFirebaseRepository movieFirebaseProvider = MovieFirebaseRepository();

    final ScrollController scrollController = ScrollController();
    return FutureBuilder(
      future: movieFirebaseProvider.loadMovies(),
      builder: (BuildContext context,
          AsyncSnapshot<List<MovieFirebaseModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Container(
                constraints: const BoxConstraints(maxWidth: 150),
                height: 180,
                width: 100,
                child: const CupertinoActivityIndicator()),
          );
        }
        final snapshotData = snapshot.data!;

        final movieSnapshot = snapshotData
            .where((movie) => movie.category == widget.category)
            .toList();

        if (movieSnapshot.isNotEmpty) {
          return SizedBox(
            width: double.infinity,
            height: size.height * 0.25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.category,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: movieSnapshot.length,
                    itemBuilder: (_, int index) =>
                        MoviePosterFirebase(movieSnapshot[index]),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
