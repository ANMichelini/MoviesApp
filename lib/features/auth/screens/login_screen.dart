import 'package:flutter/material.dart';
import 'package:peliculasdos/features/auth/widgets/auth_background.dart';
import 'package:peliculasdos/features/auth/widgets/card_container_widget.dart';
import 'package:peliculasdos/features/auth/widgets/login_form_widget.dart';
import 'package:provider/provider.dart';

import '../../../providers/providers.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: AuthBackground(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.25),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.03),
                    const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const LoginForm(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'register'),
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.red.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                ),
                child: Text(
                  'Create new account',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
