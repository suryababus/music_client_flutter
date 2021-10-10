import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Colors.brown,
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: const Color(0xFFE1D7D7),
          fontSize: 14,
          letterSpacing: 1,
          fontWeight: FontWeight.w500,
        ),
        bodyText1: TextStyle(
          color: const Color(0xFFE1D7D7),
          fontSize: 12,
          letterSpacing: 1,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
