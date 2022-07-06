import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculasdos/features/home/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (movies.isEmpty) {
      return SizedBox(
        width: size.width * 1.0,
        height: size.height * 0.38,
      );
    }
    return Container(
      margin: const EdgeInsets.all(10),
      width: size.width * 1.0,
      height: size.height * 0.3,
      child: Swiper(
        autoplayDisableOnInteraction: true,
        autoplayDelay: 20000,
        autoplay: true,
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 1.0,
        itemBuilder: (_, int index) {
          final movie = movies[index];

          movie.heroid = 'swiper-${movie.id}';
          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroid!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/movie.gif'),
                  image: NetworkImage(movie.fullBackdropPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
