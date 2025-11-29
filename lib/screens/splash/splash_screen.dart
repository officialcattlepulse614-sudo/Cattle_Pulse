import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cattle_pulse/screens/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          Colors.transparent, // IMPORTANT: Let main.dart gradient show through
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/images/cp2.png',
              height: 100,
            ),
            const SizedBox(height: 20),

            // Tagline
            Text(
              "Every Healthy Pulse Matters",
              style: TextStyle(
                fontSize: 16,
                color: isDark
                    ? const Color(0xFFF5E6C8) // Dark mode text color
                    : const Color(0xFF3B2E1A), // Light mode text color
              ),
            ),
            const SizedBox(height: 40),

            // Loading Indicator
            CircularProgressIndicator(
              color: isDark
                  ? const Color(0xFFE29B4B) //Dark Mode
                  : const Color(0xFFB87333), //Light Mode
            ),
          ],
        ),
      ),
    );
  }
}
