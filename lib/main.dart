import 'package:cattle_pulse/screens/splash/splash_screen.dart';
import 'package:cattle_pulse/controllers/menu_app_controller.dart';
import 'package:cattle_pulse/screens/menu_screens/settings_screen/notification_screen/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/// Theme notifier for switching light/dark/system
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ur'),
        Locale('ar'),
        Locale('fr'),
        Locale('es'),
      ],
      path: 'assets/translation',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, _) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => MenuAppController()),
            ChangeNotifierProvider(create: (_) => NotificationSettings()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cattle Pulse',
            themeMode: currentMode,

            /// Localization
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,

            /// Light Theme
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              primaryColor: const Color(0xFFEAD9B0),
              scaffoldBackgroundColor: Colors.transparent,
              cardColor: Colors.white.withOpacity(0.85),
              colorScheme: const ColorScheme.light(
                primary: Color(0xFFEAD9B0),
                secondary: Color(0xFFD1B585),
                surface: Color(0xFFFFF8E7),
                onPrimary: Color(0xFF2E2E2E),
                onSurface: Color(0xFF2E2E2E),
              ),
              textTheme: GoogleFonts.poppinsTextTheme()
                  .apply(bodyColor: const Color(0xFF2E2E2E)),
              iconTheme: const IconThemeData(color: Color(0xFFB68A4E)),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFFEAD9B0),
                foregroundColor: Color(0xFF2E2E2E),
                elevation: 3,
              ),
              drawerTheme:
                  const DrawerThemeData(backgroundColor: Color(0xFFFFF8E7)),
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
              cardTheme: const CardThemeData(
                elevation: 5,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),

            /// Dark Theme
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
              ),
              textTheme: GoogleFonts.poppinsTextTheme()
                  .apply(bodyColor: const Color(0xFFEAE6E1)),
              iconTheme: const IconThemeData(color: Colors.white),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF0D0D0D),
                foregroundColor: Colors.white,
                elevation: 3,
              ),
              drawerTheme:
                  const DrawerThemeData(backgroundColor: Color(0xFF000000)),
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color(0xFF121212),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF333333),
                  foregroundColor: Colors.white,
                  elevation: 3,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                  ),
                ),
              ),
              cardTheme: const CardThemeData(
                elevation: 4,
                shadowColor: Colors.white10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),

            /// Gradient background wrapper
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
                child: SafeArea(child: child ?? const SizedBox.shrink()),
              );
            },

            /// Entry point
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
