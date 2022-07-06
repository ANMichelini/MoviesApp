import 'package:peliculasdos/features/auth/services/auth_service.dart';
import 'package:provider/provider.dart';

import '../../../screens/screens.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator(
                backgroundColor: Colors.red[900],
              );
            }

            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const LoginScreen(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const NavigationScreen(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
