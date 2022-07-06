import 'package:peliculasdos/features/auth/services/auth_service.dart';
import 'package:peliculasdos/providers/providers.dart';
import 'package:peliculasdos/services/notificationservice.dart';
import 'package:peliculasdos/shared_preferences.dart/preferences.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const AppState());
  await Preferences.init();
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: NotificationService.messengerKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hintColor: Colors.grey[400],
        primaryColor: Colors.grey[850],
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          primaryColorDark: Colors.red,
          brightness: Brightness.dark,
        ),
      ),
      title: 'Peliculas DOS App',
      initialRoute: 'checking',
      routes: {
        'home': (_) => HomeScreen(),
        'details': (_) => const DetailsScreen(),
        'profile': (_) => const ProfileScreen(),
        'login': (_) => const LoginScreen(),
        'add': (_) => const AddScreen(),
        'navigation': (_) => const NavigationScreen(),
        'register': (_) => const RegisterScreen(),
        'checking': (_) => const CheckAuthScreen(),
      },
    );
  }
}
