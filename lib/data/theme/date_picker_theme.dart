import 'package:flutter/material.dart';

import 'app_theme.dart';

class DatePickerTheme {
  static ThemeData datePicker = ThemeData(
    colorScheme: ColorScheme(
      primary: AppTheme.primaryColor,
      primaryVariant: AppTheme.primaryColor,
      secondary: Colors.white,
      secondaryVariant: AppTheme.primaryColor,
      surface: AppTheme.primaryColor,
      background: Colors.white,
      error: AppTheme.accentColor,
      onPrimary: Colors.white,
      onSecondary: AppTheme.primaryColor,
      onSurface: AppTheme.primaryColor,
      onBackground: Colors.white,
      onError: AppTheme.accentColor,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      headline2: const TextStyle(color: AppTheme.primaryColor),
      caption: const TextStyle(
        color: AppTheme.primaryColor,
      ),
      button: const TextStyle(
        color: AppTheme.primaryColor,
      ),
    ),
  );
}
