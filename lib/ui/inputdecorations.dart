import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Color? color = Colors.transparent,
    void Function()? onPressed,
  }) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(prefixIcon, color: Colors.red[900]),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: onPressed,
          color: color,
        ));
  }
}
