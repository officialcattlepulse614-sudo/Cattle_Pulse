import 'package:cattle_pulse/screens/auth/login_screen.dart';
import 'package:cattle_pulse/screens/splash/splash_screen.dart';
import 'package:cattle_pulse/controllers/menu_app_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, _) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => MenuAppController()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cattle Pulse',
            themeMode: currentMode,

            // ☀️ Light Theme — Creamy & Glossy
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              primaryColor: const Color(0xFFEFE5D2),
              scaffoldBackgroundColor: const Color(0xFFFFFBF5),
              colorScheme: const ColorScheme.light(
                primary: Color(0xFFEAD9B0),
                secondary: Color(0xFFD1B585),
                surface: Color(0xFFFFFBF5),
                background: Color(0xFFFFFBF5),
                onPrimary: Colors.white,
                onSurface: Color(0xFF2E2E2E),
              ),
              textTheme: GoogleFonts.poppinsTextTheme().apply(
                bodyColor: const Color(0xFF2E2E2E),
              ),
              iconTheme: const IconThemeData(color: Color(0xFFB68A4E)),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFFF5E8C8),
                foregroundColor: Color(0xFF2E2E2E),
                elevation: 3,
              ),
              drawerTheme: const DrawerThemeData(
                backgroundColor: Color(0xFFFFF8E7),
              ),
            ),

            // 🌑 Dark Theme — Jet Black Glossy
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              primaryColor: const Color(0xFF000000),
              scaffoldBackgroundColor: const Color(0xFF000000),
              cardColor: const Color(0xFF0A0A0A),
              colorScheme: const ColorScheme.dark(
                primary: Color(0xFF000000),
                secondary: Color(0xFF121212),
                surface: Color(0xFF000000),
                background: Color(0xFF000000),
                onPrimary: Colors.white,
                onSurface: Color(0xFFEAE6E1),
              ),
              textTheme: GoogleFonts.poppinsTextTheme().apply(
                bodyColor: Color(0xFFEAE6E1),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF0D0D0D),
                foregroundColor: Colors.white,
                elevation: 3,
              ),
              drawerTheme: const DrawerThemeData(
                backgroundColor: Color(0xFF000000),
              ),
            ),

            // 🚀 Start from Splash Screen
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
