import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/notificationservice.dart';
import '../services/auth_service.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _showPassword = false;
  bool get showPassword => _showPassword;
  set showPassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void changeShowPassword() {
    if (showPassword) {
      showPassword = false;
    } else {
      showPassword = true;
    }
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<void> login(BuildContext context) async {
    if (isLoading) {
      return;
    } else {
      final authService = Provider.of<AuthService>(context, listen: false);

      if (!isValidForm()) return;
      isLoading = true;

      final String? errorMessage = await authService.login(email, password);

      if (errorMessage == null) {
        Navigator.pushReplacementNamed(context, 'navigation');
      } else {
        NotificationService.showSnackbar(errorMessage.contains('EMAIL')
            ? 'Please check your email'
            : 'Please check you password');
        isLoading = false;
      }
    }
    notifyListeners();
  }

  Future<void> createUser(BuildContext context) async {
    if (isLoading) {
      return;
    } else {
      final authService = Provider.of<AuthService>(context, listen: false);

      if (!isValidForm()) return;
      isLoading = true;

      final String? errorMessage =
          await authService.createUser(email, password);

      if (errorMessage == null) {
        Navigator.pushReplacementNamed(context, 'login');
      } else {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('This email is not available, please use another one.'),
          ),
        );
      }
      notifyListeners();
    }
  }
}
