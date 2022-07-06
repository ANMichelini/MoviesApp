import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/providers.dart';
import '../../../ui/inputdecorations.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formKey,
      child: Column(
        children: [
          TextFormField(
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
                  : 'The value does not look like an e-mail';
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
              onPressed: () => loginForm.changeShowPassword(),
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
          SizedBox(height: size.height * 0.06),
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
                loginForm.isLoading ? 'Please wait...' : 'Log in',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              loginForm.login(context);
            },
          ),
          SizedBox(height: size.height * 0.02),
        ],
      ),
    );
  }
}
