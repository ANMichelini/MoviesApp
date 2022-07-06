import 'package:peliculasdos/models/models.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({Key? key, required this.movieFirebaseModel})
      : super(key: key);

  final MovieFirebaseModel movieFirebaseModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 31),
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                _inputText(
                    context,
                    movieFirebaseModel.price != null
                        ? '\$${movieFirebaseModel.price}'
                        : '-'),
                const SizedBox(width: 10),
                _inputText(context, movieFirebaseModel.place ?? '-'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _inputText(context, movieFirebaseModel.category.toString()),
                const SizedBox(width: 10),
                _inputText(context, movieFirebaseModel.acquisitiondate ?? '-'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputText(BuildContext context, String text) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(4, 6),
              blurRadius: 10,
            ),
          ],
          color: Colors.grey[500]?.withOpacity(0.2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 50,
        width: size.width * 0.4,
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
              text,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
