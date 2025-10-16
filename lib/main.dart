import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cattle_pulse/controllers/menu_app_controller.dart';
import 'package:cattle_pulse/screens/main/main_screen.dart';
import 'package:cattle_pulse/themes/theme_provider.dart';
import 'package:cattle_pulse/themes/app_themes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuAppController()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cattle Pulse',
      themeMode: themeProvider.themeMode,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      home: const MainScreen(),
    );
  }
}
