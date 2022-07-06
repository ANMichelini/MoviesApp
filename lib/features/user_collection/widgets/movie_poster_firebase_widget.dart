import '../../../screens/screens.dart';

class MoviePosterFirebase extends StatelessWidget {
  const MoviePosterFirebase(this.movie, {Key? key}) : super(key: key);

  final MovieFirebaseModel movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Hero(
      tag: movie.heroid!,
      child: Container(
        width: size.width * 0.3,
        height: size.height * 0.2,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DetailsScreen(
                isMovieFirebase: true,
              ),
              settings: RouteSettings(arguments: movie),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              fadeOutDuration: const Duration(milliseconds: 200),
              placeholder: const AssetImage('assets/loadingmovie.gif'),
              image: NetworkImage(
                movie.posterpath != null
                    ? movie.fullPosterImg
                    : 'https://via.placeholder.com/300x400',
              ),
              height: size.height * 0.2,
              width: size.width * 0.3,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
