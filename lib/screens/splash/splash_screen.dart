import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cattle_pulse/screens/auth/auth_gate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToAuthGate();
  }

  Future<void> _navigateToAuthGate() async {
    // Show splash for 3-5 seconds
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // Navigate to AuthGate (which will handle login/home routing)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AuthGate()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
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
                color:
                    isDark ? const Color(0xFFF5E6C8) : const Color(0xFF3B2E1A),
              ),
            ),
            const SizedBox(height: 40),

            // Loading Indicator
            CircularProgressIndicator(
              color: isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333),
            ),
          ],
        ),
      ),
    );
  }
}
