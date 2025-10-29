import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:cattle_pulse/screens/splash/splash_screen.dart';
import 'package:cattle_pulse/controllers/menu_app_controller.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ur'),
        Locale('pa'),
        Locale('sd'),
        Locale('ps'),
        Locale('bal'),
        Locale('ar'),
        Locale('zh'),
        Locale('fr'),
        Locale('de'),
        Locale('es'),
        Locale('ru'),
        Locale('tr'),
        Locale('ja'),
        Locale('ko'),
        Locale('it'),
        Locale('pt'),
      ],
      path: 'assets/translations', // or 'translations' based on your setup
      fallbackLocale: const Locale('en'),
      child: const MyAppWrapper(),
    ),
  );
}

class MyAppWrapper extends StatelessWidget {
  const MyAppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
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
            // 🪄 Add these lines:
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,

            // ✅ Your themes...
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),

            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
