import 'package:peliculasdos/models/models.dart';

class NavigationProvider with ChangeNotifier {
  int _currentPage = 0;

  final PageController _pageController = PageController(); 

  set currentPage(int value) {
    _currentPage = value;

    _pageController.animateToPage(value,
        duration: const Duration(
          milliseconds: 100,
        ),
        curve: Curves.easeOut);

    notifyListeners();
  }
 
  int get currentPage => _currentPage;

  PageController get pageController => _pageController;
}