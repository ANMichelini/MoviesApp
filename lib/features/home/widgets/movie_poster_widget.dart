import 'package:flutter/material.dart';

import '../models/movie_model.dart';

class MoviePoster extends StatelessWidget {
  final Movie movie;
  final String heroId;

  const MoviePoster(this.movie, this.heroId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    movie.heroid = heroId;
    return Container(
      height: size.height * 0.21,
      width: size.width * 0.31,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroid!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    fadeOutDuration: const Duration(milliseconds: 200),
                    placeholder: const AssetImage('assets/loadingmovie.gif'),
                    image: NetworkImage(movie.fullPosterImg),
                    height: size.height * 0.2,
                    width: size.width * 0.3,
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
