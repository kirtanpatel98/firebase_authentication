import 'package:flutter/material.dart';

class AppTheme {
  static const Color kBlack = Colors.black;
  static const kShadowColor = Color(0xFF52555F);
  static const primaryColor = Color(0xff273D54);
  static const accentColor = const Color(0xff172536);
  final ThemeData appThemeData = ThemeData(
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        fontSize: 16.0,
      ),
    ),
  );
}
