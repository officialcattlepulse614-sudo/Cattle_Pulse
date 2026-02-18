import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:cattle_pulse/screens/main/home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          final theme = Theme.of(context);
          final isDark = theme.brightness == Brightness.dark;

          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: CircularProgressIndicator(
                color:
                    isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333),
              ),
            ),
          );
        }

        // Check if user is logged in
        final user = snapshot.data;

        if (user != null) {
          // User is logged in - show HomeScreen
          // Add a small delay to allow success dialog to show properly
          return FutureBuilder(
            future: Future.delayed(const Duration(milliseconds: 100)),
            builder: (context, delaySnapshot) {
              if (delaySnapshot.connectionState == ConnectionState.done) {
                return const HomeScreen();
              }
              // Show loading indicator during the delay
              final theme = Theme.of(context);
              final isDark = theme.brightness == Brightness.dark;
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: CircularProgressIndicator(
                    color: isDark
                        ? const Color(0xFFE29B4B)
                        : const Color(0xFFB87333),
                  ),
                ),
              );
            },
          );
        } else {
          // User is logged out - show LoginScreen
          return const LoginScreen();
        }
      },
    );
  }
}
