// lib/screens/menu_screens/settings_screen/language_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  // List of supported languages
  final List<Map<String, dynamic>> languages = const [
    {'name': 'English', 'locale': Locale('en')},
    {'name': 'Urdu', 'locale': Locale('ur')},
    {'name': 'Arabic', 'locale': Locale('ar')},
    {'name': 'Spanish', 'locale': Locale('es')},
    {'name': 'French', 'locale': Locale('fr')},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currentLocale = context.locale;

    // Transparent system bars
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            // Floating AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: Material(
                elevation: 8,
                shadowColor: Colors.black26,
                borderRadius: BorderRadius.circular(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 50,
                    color: isDark
                        ? const Color(0xFF1F1B18)
                        : const Color.fromARGB(255, 230, 218, 198),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: isDark
                                ? const Color(0xFFE29B4B)
                                : const Color(0xFFB87333),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Language'.tr(),
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            letterSpacing: 0.8,
                            color: isDark
                                ? const Color(0xFFF5E6C8)
                                : const Color(0xFF3B2E1A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Select Preferred Language'.tr(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? const Color(0xFFF5E6C8)
                            : const Color(0xFF3B2E1A),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Language list
                    ...languages.map(
                      (lang) => Card(
                        color: isDark
                            ? (currentLocale == lang['locale']
                                ? const Color(0xFFE29B4B).withOpacity(0.2)
                                : const Color(0xFF1E1E1E))
                            : (currentLocale == lang['locale']
                                ? const Color(0xFFB87333).withOpacity(0.2)
                                : const Color.fromARGB(255, 248, 234, 220)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ListTile(
                          title: Text(
                            lang['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF3B2E1A),
                            ),
                          ),
                          trailing: currentLocale == lang['locale']
                              ? Icon(Icons.check,
                                  color: isDark
                                      ? const Color(0xFFE29B4B)
                                      : const Color(0xFFB87333))
                              : null,
                          onTap: () {
                            context.setLocale(lang['locale']);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
