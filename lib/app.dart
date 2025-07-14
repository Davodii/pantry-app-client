// app.dart
import 'package:flutter/material.dart';
import 'package:pantry_app/core/theme/app_theme.dart';
import 'package:pantry_app/core/theme/theme_provider.dart';
import 'package:pantry_app/home_screen.dart';
import 'package:provider/provider.dart';

class PantryApp extends StatelessWidget {
  const PantryApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Pantry App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeProvider.themeMode,
      home: HomeScreen(),
    );
  }
}
