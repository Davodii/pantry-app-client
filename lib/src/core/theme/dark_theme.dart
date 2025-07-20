import 'package:flutter/material.dart';
import 'package:pantry_app/src/core/constants/app_colors.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: AppColors.primaryDark,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primaryDark,
    foregroundColor: Colors.white,
  ),
  cardColor: const Color(0xFF1E1E1E),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white70),
  ),
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryDark,
    secondary: AppColors.accent,
    error: AppColors.error,
  ),
);
