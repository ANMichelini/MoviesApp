import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final dynamic movie;
  final bool isMovieFirebase;
  const CustomAppBar(this.movie, this.isMovieFirebase, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.grey[900],
      expandedHeight: size.height * 0.3,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          padding: const EdgeInsets.only(
            bottom: 10,
            left: 10,
            right: 10,
          ),
          color: Colors.black12,
          child: Text(
            movie.title,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/movie.gif'),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
