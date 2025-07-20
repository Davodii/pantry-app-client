import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/app/app.dart';
import 'src/core/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const PantryApp(),
    ),
  );
}
