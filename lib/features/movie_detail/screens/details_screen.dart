import 'package:peliculasdos/features/movie_detail/widgets/casting_cards_widget.dart';
import 'package:peliculasdos/features/movie_detail/widgets/details_card_widget.dart';

import '../../../screens/screens.dart';
import '../widgets/custom_app_bar_widget.dart';
import '../widgets/poster_title_widget.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    this.isMovieFirebase = false,
    Key? key,
  }) : super(key: key);

  final bool isMovieFirebase;

  @override
  Widget build(BuildContext context) {
    final dynamic movie = ModalRoute.of(context)!.settings.arguments;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          CustomAppBar(movie, isMovieFirebase),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                if (isMovieFirebase) DetailsCard(movieFirebaseModel: movie),
                SizedBox(height: size.height * 0.02),
                PosterAndTitle(movie, isMovieFirebase),
                const SizedBox(height: 10),
                Overview(movie),
                const SizedBox(height: 10),
                CastingCards(movie.id),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Overview extends StatelessWidget {
  final dynamic movie;

  const Overview(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
