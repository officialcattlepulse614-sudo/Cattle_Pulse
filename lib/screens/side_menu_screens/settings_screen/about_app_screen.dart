// lib/screens/menu_screens/settings_screen/about_app_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
                          'About App',
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
                      'CattlePulse',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? const Color(0xFFF5E6C8)
                            : const Color(0xFF3B2E1A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Version 1.0.0\n\nCattlePulse is a smart livestock monitoring system designed to help farmers track health, temperature, humidity, and real-time statistics of their cattle.',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Developed by:\nTech Guy & Team',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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
