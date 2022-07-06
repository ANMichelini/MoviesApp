import 'package:flutter/cupertino.dart';
import 'package:peliculasdos/features/user_collection/widgets/movie_slider_collection_widget.dart';
import 'package:peliculasdos/features/user_collection/widgets/name_and_phrase_widget.dart';

import '../../../screens/screens.dart';
import '../../../shared_preferences.dart/preferences.dart';
import '../../auth/services/auth_service.dart';
import '../../search/search_delegate.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ALERT

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: MovieSearchDelegate('add'),
          );
        },
        child: const Icon(Icons.add),
        materialTapTargetSize: MaterialTapTargetSize.padded,
        backgroundColor: Colors.red[900],
        foregroundColor: Colors.white,
        elevation: 3,
      ),
      appBar: AppBar(
        title: (const Text('My Collection')),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => displayDialogAndroid(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            NameAndPhraseWidget(size: size),
            const SizedBox(height: 20),
            const MovieSliderCollection(category: 'Horror'),
            const MovieSliderCollection(category: 'Thriller'),
            const MovieSliderCollection(category: 'Comedy'),
            const MovieSliderCollection(category: 'Science Fiction'),
            const MovieSliderCollection(category: 'Drama'),
            const MovieSliderCollection(category: 'Romance'),
            const MovieSliderCollection(category: 'Action'),
          ],
        ),
      ),
    );
  }

// ALERT

  void displayDialogAndroid() {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 5,
          title: Text('Movies', style: TextStyle(color: Colors.grey[500])),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              Text(
                'Do you want to log out?',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(10),
          ),
          actions: [
            TextButton(
              onPressed: () {
                dynamic logout = true;

                if (logout) {
                  Preferences.phrase = '';
                }

                AuthService().logout();

                Navigator.pushNamedAndRemoveUntil(
                    context, 'login', (Route<dynamic> route) => false);
              },
              child: Text(
                'Ok',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ),
            const SizedBox(width: 5),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(width: 10),
          ],
        );
      },
    );
  }
}
