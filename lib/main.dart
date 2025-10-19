import 'package:cattle_pulse/screens/main/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cattle_pulse/controllers/menu_app_controller.dart';

// Global theme notifier used by SideMenu and the MaterialApp
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Rebuild MaterialApp whenever themeNotifier changes
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        // Build text themes once and reuse
        final baseLight = ThemeData.light();
        final baseDark = ThemeData.dark();

        final textThemeLight = GoogleFonts.poppinsTextTheme(baseLight.textTheme)
            .apply(bodyColor: Colors.black87);
        final textThemeDark = GoogleFonts.poppinsTextTheme(baseDark.textTheme)
            .apply(bodyColor: Colors.white70);

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MenuAppController(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cattle Pulse',
            themeMode: currentMode,
            // Light theme
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.green,
              scaffoldBackgroundColor: Colors.white,
              textTheme: textThemeLight,
              canvasColor: Colors.transparent,
              drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFFF2F2F2),
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black87),
              ),
            ),
            // Dark theme
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.green,
              scaffoldBackgroundColor: const Color(0xFF0F1724),
              textTheme: textThemeDark,
              canvasColor: Colors.transparent,
              drawerTheme:
                  const DrawerThemeData(backgroundColor: Color(0xFF0B1320)),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF111827),
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.white70),
              ),
            ),

            // Pass themeNotifier into MainScreen so the SideMenu can toggle it
            home: GradientWrapper(
              child: HomeScreen(themeNotifier: themeNotifier),
            ),
          ),
        );
      },
    );
  }
}

class GradientWrapper extends StatelessWidget {
  final Widget child;
  const GradientWrapper({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Use theme-aware background so header & page follow dark/light
    final List<Color> colors = theme.brightness == Brightness.dark
        ? [const Color(0xFF0B1220), const Color(0xFF0F1724)]
        : [const Color(0xFFFFFFFF), const Color(0xFFF7FBF4)];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: child,
      ),
    );
  }
}
