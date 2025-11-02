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

            // ☀️ Light Theme — Creamy Gradient & Glossy
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              primaryColor: const Color(0xFFEAD9B0),
              scaffoldBackgroundColor: Colors.transparent, // For gradient
              cardColor: Colors.white.withOpacity(0.85),
              colorScheme: const ColorScheme.light(
                primary: Color(0xFFEAD9B0),
                secondary: Color(0xFFD1B585),
                surface: Color(0xFFFFF8E7),
                onPrimary: Color(0xFF2E2E2E),
                onSurface: Color(0xFF2E2E2E),
                error: Color(0xFFD32F2F),
                errorContainer: Color(0xFFFFCDD2),
                primaryContainer: Color(0xFFF0EAE0),
                tertiaryContainer: Color(0xFFE5F6E3),
              ),
              textTheme: GoogleFonts.poppinsTextTheme().apply(
                bodyColor: const Color(0xFF2E2E2E),
              ),
              iconTheme: const IconThemeData(color: Color(0xFFB68A4E)),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFFF5E8C8),
                foregroundColor: Color(0xFF2E2E2E),
                elevation: 4,
                shadowColor: Color(0x33B68A4E),
              ),
              drawerTheme: const DrawerThemeData(
                backgroundColor: Color(0xFFFFF8E7),
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.7),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD1B585),
                  foregroundColor: Colors.white,
                  elevation: 3,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                  ),
                ),
              ),
              // FIX: Changed CardTheme back to CardThemeData and REMOVED 'const'
              cardTheme: CardThemeData(
                elevation: 5,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            // 🌑 Dark Theme — Jet Black Glossy
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              primaryColor: const Color(0xFF000000),
              scaffoldBackgroundColor: Colors.transparent,
              cardColor: const Color(0xFF0A0A0A),
              colorScheme: const ColorScheme.dark(
                primary: Color(0xFF000000),
                secondary: Color(0xFF121212),
                surface: Color(0xFF000000),
                onPrimary: Color(0xFFEAE6E1),
                onSurface: Color(0xFFEAE6E1),
                error: Color(0xFFEF5350),
                errorContainer: Color(0xFF450000),
                primaryContainer: Color(0xFF1A1A1A),
                tertiaryContainer: Color(0xFF0A200B),
              ),
              textTheme: GoogleFonts.poppinsTextTheme().apply(
                bodyColor: const Color(0xFFEAE6E1),
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
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFF121212),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF333333),
                  foregroundColor: Colors.white,
                  elevation: 3,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                  ),
                ),
              ),
              // FIX: Changed CardTheme back to CardThemeData and REMOVED 'const'
              cardTheme: CardThemeData(
                elevation: 4,
                shadowColor: Colors.white10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            // 🪄 Global gradient background wrapper
            builder: (context, child) {
              final isDark = Theme.of(context).brightness == Brightness.dark;

              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [
                            const Color(0xFF000000),
                            const Color(0xFF111111),
                            const Color(0xFF0A0A0A),
                          ]
                        : [
                            const Color(0xFFFFF8E7),
                            const Color(0xFFEAD9B0),
                            const Color(0xFFD1B585),
                          ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: child,
              );
            },

            // 🚀 Start from Splash Screen
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
