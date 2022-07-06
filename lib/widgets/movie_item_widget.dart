import 'package:flutter/material.dart';

import '../features/home/models/movie_model.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  final String route;
  const MovieItem(this.movie, this.route, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    movie.heroid = 'search${movie.id}';
    return ListTile(
        leading: Hero(
          tag: movie.heroid!,
          child: FadeInImage(
            fadeOutDuration: const Duration(milliseconds: 200),
            placeholder: const AssetImage('assets/loadingmovie.gif'),
            image: NetworkImage(movie.fullPosterImg),
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(movie.title),
        subtitle: Row(
          children: [
            const Icon(Icons.star_border, size: 10),
            const SizedBox(width: 2),
            Text(movie.voteAverage.toString()),
          ],
        ),
        onTap: () {
          Navigator.pushReplacementNamed(context, route, arguments: movie);
        });
  }
}
