import 'package:flutter/material.dart';
import 'package:peliculasdos/features/auth/widgets/auth_background.dart';
import 'package:peliculasdos/features/auth/widgets/card_container_widget.dart';
import 'package:provider/provider.dart';

import '../../../providers/providers.dart';
import '../widgets/register_form_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
                      'Create account',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const RegisterForm(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'login'),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.red[900]),
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                ),
                child: Text(
                  'Have already an account?',
                  style: TextStyle(fontSize: 18, color: Colors.grey[500]),
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
