import 'package:flutter/material.dart';

class NotificationService {
  static late GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackbar = SnackBar(
      content: Text(
        
        message,
        style: TextStyle(
          color: Colors.red[900],
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
    messengerKey.currentState!.showSnackBar(snackbar);
  }
}
