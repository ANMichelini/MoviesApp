import 'package:peliculasdos/features/navigation/provider/navigation_provider.dart';
import 'package:provider/provider.dart';

import '../../../screens/screens.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
      child: Scaffold(
        body: const Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class Pages extends StatefulWidget {
  const Pages({Key? key}) : super(key: key);

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<NavigationProvider>(context);
    return PageView(
      controller: navigationModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        HomeScreen(),
        const ProfileScreen(),
      ],
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<NavigationProvider>(context);

    return BottomNavigationBar(
      currentIndex: navigationModel.currentPage,
      onTap: (i) => navigationModel.currentPage = i,
      iconSize: 30,
      selectedItemColor: Colors.red[900],
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'My Collection',
        ),
      ],
    );
  }
}
