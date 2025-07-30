import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/app/app.dart';
import 'src/app/theme/theme_provider.dart';
import 'src/core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup dependency injection
  setupLocator();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const PantryApp(),
    ),
  );
}
