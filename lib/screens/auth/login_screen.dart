import 'package:flutter/material.dart';
import 'package:cattle_pulse/screens/main/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/cp2.png',
                    height: 100,
                  ),
                  const SizedBox(height: 16),

                  // Tagline
                  Text(
                    'Every Healthy Pulse Matters',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark
                          ? const Color(0xFFF5E6C8)
                          : const Color(0xFF3B2E1A),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // Username
                  TextField(
                    cursorColor: isDark
                        ? const Color(0xFFF5E6C8).withOpacity(0.8)
                        : const Color(0xFF3B2E1A).withOpacity(0.8),
                    style: TextStyle(
                      color: isDark
                          ? const Color(0xFFF5E6C8)
                          : const Color(0xFF3B2E1A),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: isDark
                          ? const Color(0xFF1F1B18).withOpacity(0.8)
                          : const Color(0xFFE6DAC6).withOpacity(0.8),
                      hintText: 'Username',
                      hintStyle: TextStyle(
                        color: isDark
                            ? const Color(0xFFF5E6C8).withOpacity(0.8)
                            : const Color(0xFF3B2E1A).withOpacity(0.8),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password
                  TextField(
                    cursorColor: isDark
                        ? const Color(0xFFF5E6C8).withOpacity(0.8)
                        : const Color(0xFF3B2E1A).withOpacity(0.8),
                    obscureText: true,
                    style: TextStyle(
                      color: isDark
                          ? const Color(0xFFF5E6C8)
                          : const Color(0xFF3B2E1A),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: isDark
                          ? const Color(0xFF1F1B18).withOpacity(0.8)
                          : const Color(0xFFE6DAC6).withOpacity(0.8),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: isDark
                            ? const Color(0xFFF5E6C8).withOpacity(0.8)
                            : const Color(0xFF3B2E1A).withOpacity(0.8),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: isDark
                              ? const Color(0xFFF5E6C8).withOpacity(0.8)
                              : const Color(0xFF3B2E1A).withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Login Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark
                          ? const Color(0xFF362C25)
                          : const Color.fromARGB(255, 255, 232, 192),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: isDark
                            ? const Color(0xFFF5E6C8)
                            : const Color.fromARGB(202, 59, 46, 26),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
