import 'package:animate_do/animate_do.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:peliculasdos/features/user_collection/repository/movie_firebase_repository.dart';
import 'package:peliculasdos/screens/screens.dart';
import 'package:peliculasdos/services/notificationservice.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String _date = '';
  final TextEditingController _inputFieldDateController =
      TextEditingController();

  final List<String> _categorys = [
    'Science Fiction',
    'Thriller',
    'Horror',
    'Comedy',
    'Drama',
    'Romance',
    'Action'
  ];
  MovieFirebaseModel movieFirebase = MovieFirebaseModel();
  final movieFirebaseProvider = MovieFirebaseRepository();

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: SlideInLeft(
          child: const Text('New movie'),
          delay: const Duration(milliseconds: 100),
          duration: const Duration(milliseconds: 500),
          from: 150,
        ),
        backgroundColor: Colors.red[900],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin:
              const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 5),
          width: double.infinity,
          height: size.height * 0.85,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                'What movie did you colect today?',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 25),
              BounceInLeft(
                  child: Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  delay: const Duration(milliseconds: 800)),
              const SizedBox(height: 25),
              _createPrice(),
              const SizedBox(height: 10),
              _createPlace(
                  'Place', 'Avenue 3 Videoclub', TextInputType.streetAddress),
              const SizedBox(height: 10),
              _createFormat('Format', 'DVD', TextInputType.text),
              const SizedBox(height: 10),
              _createDate(context),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: _createDropdown(),
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[900],
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  onPressed: () {
                    if (movieFirebase.category == null) {
                      NotificationService.showSnackbar(
                          'Please pick a movie genre');
                    } else {
                      saveOrCreateMovie(movie);

                      Navigator.pushNamedAndRemoveUntil(
                          context, 'navigation', (route) => false);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveOrCreateMovie(Movie movie) {
    movieFirebase.title = movie.title;
    movieFirebase.originaltitle = movie.originalTitle;
    movieFirebase.overview = movie.overview;
    movieFirebase.posterpath = movie.posterPath;
    movieFirebase.voteaverage = movie.voteAverage.toString();
    movieFirebase.backdroppath = movie.backdropPath;
    movieFirebase.heroid = movie.heroid;
    movieFirebase.id = movie.id;

    setState(() {
      movieFirebaseProvider.createMovie(movieFirebase);
    });
  }

  Widget _createFormat(String label, String hint, dynamic textInput) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            movieFirebase.format = value;
          });
        },
        textCapitalization: TextCapitalization.words,
        autofocus: false,
        textInputAction: TextInputAction.done,
        cursorColor: Colors.white,
        keyboardType: textInput,
        maxLines: 2,
        textAlign: TextAlign.start,
        style: const TextStyle(overflow: TextOverflow.ellipsis),
        autocorrect: false,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.only(left: 10, right: 10),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          labelText: label,
          labelStyle: TextStyle(
            fontStyle: FontStyle.italic,
            overflow: TextOverflow.ellipsis,
            color: Colors.grey[400],
          ),
          hintText: hint,
          hintStyle:
              const TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
        ),
      ),
    );
  }

  Widget _createPrice() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
        ],
        onChanged: (value) {
          setState(() {
            movieFirebase.price = value;
          });
        },
        textCapitalization: TextCapitalization.words,
        autofocus: false,
        textInputAction: TextInputAction.done,
        cursorColor: Colors.white,
        keyboardType: TextInputType.number,
        maxLines: 2,
        textAlign: TextAlign.start,
        style: const TextStyle(overflow: TextOverflow.ellipsis),
        autocorrect: false,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.only(left: 10, right: 10),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          labelText: 'Price',
          labelStyle: TextStyle(
              fontStyle: FontStyle.italic,
              overflow: TextOverflow.ellipsis,
              color: Colors.grey[400]),
          hintText: '\$18.90',
          hintStyle:
              const TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
        ),
      ),
    );
  }

  Widget _createPlace(String label, String hint, dynamic textInput) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            movieFirebase.place = value;
          });
        },
        textCapitalization: TextCapitalization.words,
        autofocus: false,
        textInputAction: TextInputAction.done,
        cursorColor: Colors.white,
        keyboardType: textInput,
        maxLines: 2,
        textAlign: TextAlign.start,
        style: const TextStyle(overflow: TextOverflow.ellipsis),
        autocorrect: false,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.only(left: 10, right: 10),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          labelText: label,
          labelStyle: TextStyle(
              fontStyle: FontStyle.italic,
              overflow: TextOverflow.ellipsis,
              color: Colors.grey[400]),
          hintText: hint,
          hintStyle:
              const TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
        ),
      ),
    );
  }

  Widget _createDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
          enableInteractiveSelection: false,
          controller: _inputFieldDateController,
          textInputAction: TextInputAction.done,
          cursorColor: Colors.white,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            contentPadding: const EdgeInsets.only(left: 10, right: 10),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            labelText: 'Acquisition date',
            labelStyle: TextStyle(
                fontStyle: FontStyle.italic,
                overflow: TextOverflow.ellipsis,
                color: Colors.grey[400]),
            hintText: '10/11/2015',
            hintStyle: const TextStyle(
                fontStyle: FontStyle.italic, color: Colors.white),
          ),
          // textCapitalization: TextCapitalization.sentences,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            _selectDate(context);
          }),
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1995),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        final _formatdate = DateFormat('dd/MM/yyyy');
        _date = _formatdate.format(picked);
        _inputFieldDateController.text = _date;
        movieFirebase.acquisitiondate = _date;
      });
    }
  }

  List<DropdownMenuItem<String>> getDropdownOptions() {
    var list = <DropdownMenuItem<String>>[];

    for (var category in _categorys) {
      list.add(
        DropdownMenuItem(
          child: Text(category),
          value: category,
        ),
      );
    }

    return list;
  }

  Widget _createDropdown() {
    return Row(
      children: <Widget>[
        const SizedBox(width: 5),
        Icon(Icons.movie, color: Colors.red[900]),
        const SizedBox(width: 15.0),
        Expanded(
          child: DropdownButtonFormField(
            hint: const Text('Movie genre',
                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
            alignment: AlignmentDirectional.centerStart,
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey[400],
                decorationColor: Colors.white),
            value: movieFirebase.category,
            items: getDropdownOptions(),
            onChanged: (opt) {
              setState(() {
                movieFirebase.category = opt.toString();
              });
            },
          ),
        )
      ],
    );
  }
}
