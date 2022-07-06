import 'package:flutter/material.dart';

class PosterAndTitle extends StatelessWidget {
  final dynamic movie;
  final bool isMovieFirebase;
  const PosterAndTitle(this.movie, this.isMovieFirebase, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroid!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                fadeOutDuration: const Duration(milliseconds: 900),
                placeholder: const AssetImage('assets/loadingmovie.gif'),
                image: NetworkImage(movie.fullPosterImg),
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width - 180),
                child: Text(
                  isMovieFirebase ? movie.originaltitle : movie.originalTitle,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(
                    Icons.star_outline,
                    size: 15,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    isMovieFirebase
                        ? movie.voteaverage.toString()
                        : movie.voteAverage.toString(),
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
