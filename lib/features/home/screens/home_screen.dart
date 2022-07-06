import 'package:flutter/material.dart';
import 'package:peliculasdos/features/home/widgets/card_swiper_widget.dart';
import 'package:peliculasdos/features/home/widgets/movie_slider_widget.dart';
import 'package:peliculasdos/features/search/search_delegate.dart';
import 'package:peliculasdos/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../../../screens/screens.dart';

class HomeScreen extends StatelessWidget {
  final scrollController = ScrollController();

  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate('details'),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: const Text('Movies'),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            const SizedBox(height: 5),
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Popular',
              onNextPage: () => moviesProvider.fetchPopularMovies(),
            ),
            const SizedBox(height: 5),
            MovieSlider(
              movies: moviesProvider.upcomingMovies,
              title: 'Upcoming',
              onNextPage: () => moviesProvider.fetchUpcomingMovies(),
            ),
            const SizedBox(height: 5),
            MovieSlider(
              movies: moviesProvider.topRatedMovies,
              title: 'Top Rated',
              onNextPage: () => moviesProvider.fetchTopRatedMovies(),
            ),
          ],
        ),
      ),
    );
  }
}
