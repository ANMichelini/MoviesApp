import 'package:flutter/material.dart';
import 'package:peliculasdos/providers/providers.dart';
import 'package:provider/provider.dart';

import '../../../shared_preferences.dart/preferences.dart';
import '../../../ui/inputdecorations.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final preferences = Preferences();

    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formKey,
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.done,
            autocorrect: false,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'Amelie Bell',
              labelText: 'Username',
              prefixIcon: Icons.person,
            ),
            validator: (value) {
              if (value == '' || value == null) {
                return 'Required field';
              }
              return null;
            },
            onChanged: (value) => preferences.username = value,
          ),
          SizedBox(height: size.height * 0.04),
          TextFormField(
            textInputAction: TextInputAction.done,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'john.doe@gmail.com',
              labelText: 'E-mail',
              prefixIcon: Icons.alternate_email_sharp,
            ),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'The value does not look like an e-mail.';
            },
          ),
          SizedBox(height: size.height * 0.04),
          TextFormField(
            autocorrect: false,
            obscureText: (loginForm.showPassword) ? false : true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              color: (loginForm.showPassword) ? Colors.red[900] : Colors.white,
              suffixIcon: (loginForm.showPassword)
                  ? Icons.remove_red_eye
                  : Icons.remove_red_eye_outlined,
              onPressed: () {
                if (loginForm.showPassword) {
                  loginForm.showPassword = false;
                } else {
                  loginForm.showPassword = true;
                }
              },
              hintText: '********',
              labelText: 'Password',
              prefixIcon: Icons.lock_clock_outlined,
            ),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              if (value != null && value.length >= 6) return null;

              return 'Password must contain six characters';
            },
          ),
          SizedBox(height: size.height * 0.04),
          MaterialButton(
            splashColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.red[900],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              child: Text(
                loginForm.isLoading ? 'Please wait...' : 'Sign in',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            onPressed: () async {
              if (loginForm.formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                loginForm.createUser(context);
              }
            },
          ),
          SizedBox(height: size.height * 0.02),
        ],
      ),
    );
  }
}
