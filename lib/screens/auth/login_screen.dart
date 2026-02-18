import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cattle_pulse/screens/auth/session_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  bool loading = false;
  bool obscurePassword = true;

  // -------- SUCCESS DIALOG --------
  Future<void> showSuccessDialog() async {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        // Auto-dismiss after 1.2 seconds using the dialog's context
        Future.delayed(const Duration(milliseconds: 1200), () {
          if (Navigator.of(dialogContext).canPop()) {
            Navigator.of(dialogContext).pop();
          }
        });

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1F1B18) : const Color(0xFFE6DAC6),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success Icon
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    LucideIcons.checkCircle,
                    size: 48,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                Text(
                  "Login Successful!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: isDark
                        ? const Color(0xFFF5E6C8)
                        : const Color(0xFF3B2E1A),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Message
                Text(
                  "Welcome back! Redirecting to home...",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? const Color(0xFFF5E6C8).withOpacity(0.8)
                        : const Color(0xFF3B2E1A).withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Loading Indicator
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF4CAF50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // -------- CUSTOM ERROR DIALOG --------
  void showErrorDialog(String title, String message, IconData icon) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1F1B18) : const Color(0xFFE6DAC6),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Error Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE53935).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 48,
                  color: const Color(0xFFE53935),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: isDark
                      ? const Color(0xFFF5E6C8)
                      : const Color(0xFF3B2E1A),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Message
              Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? const Color(0xFFF5E6C8).withOpacity(0.8)
                      : const Color(0xFF3B2E1A).withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // OK Button
              InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53935),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    "Try Again",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------- SHOW MESSAGE WITH APPROPRIATE DIALOG --------
  void showMessage(String errorCode) {
    if (errorCode.contains('user-not-found') ||
        errorCode.contains('invalid-email')) {
      showErrorDialog(
        "Email Not Found",
        "The email address you entered doesn't exist in our system. Please check and try again.",
        LucideIcons.mailX,
      );
    } else if (errorCode.contains('wrong-password') ||
        errorCode.contains('invalid-credential')) {
      showErrorDialog(
        "Incorrect Password",
        "The password you entered is incorrect. Please try again or reset your password.",
        LucideIcons.lock,
      );
    } else if (errorCode.contains('too-many-requests')) {
      showErrorDialog(
        "Too Many Attempts",
        "Access temporarily disabled due to many failed login attempts. Please try again later.",
        LucideIcons.shieldAlert,
      );
    } else if (errorCode.contains('network-request-failed')) {
      showErrorDialog(
        "Network Error",
        "Unable to connect to the server. Please check your internet connection and try again.",
        LucideIcons.wifiOff,
      );
    } else {
      showErrorDialog(
        "Login Error",
        errorCode.isEmpty
            ? "An unexpected error occurred. Please try again."
            : errorCode,
        LucideIcons.alertCircle,
      );
    }
  }

  // -------- LOGIN FUNCTION --------
  Future<void> loginUser() async {
    if (emailCtrl.text.trim().isEmpty || passwordCtrl.text.trim().isEmpty) {
      showErrorDialog(
        "Missing Fields",
        "Please enter both email and password to continue.",
        LucideIcons.alertTriangle,
      );
      return;
    }

    setState(() => loading = true);

    try {
      // Sign in with Firebase
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailCtrl.text.trim(),
        password: passwordCtrl.text.trim(),
      );

      // ✅ Register successful login with session manager
      await SessionManager().onLoginSuccess();

      // ✅ Show success dialog and WAIT for it to complete
      if (mounted) {
        await showSuccessDialog();
      }

      // ✅ The AuthGate StreamBuilder will automatically navigate to HomeScreen
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        showMessage(e.code);
      }
    } catch (e) {
      if (mounted) {
        showErrorDialog(
          "Login Error",
          e.toString(),
          LucideIcons.alertCircle,
        );
      }
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

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

                  // Email
                  TextField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
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
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: isDark
                            ? const Color(0xFFF5E6C8).withOpacity(0.8)
                            : const Color(0xFF3B2E1A).withOpacity(0.8),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password with Eye Icon
                  TextField(
                    controller: passwordCtrl,
                    cursorColor: isDark
                        ? const Color(0xFFF5E6C8).withOpacity(0.8)
                        : const Color(0xFF3B2E1A).withOpacity(0.8),
                    obscureText: obscurePassword,
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? LucideIcons.eyeOff
                              : LucideIcons.eye,
                          color: isDark
                              ? const Color(0xFFF5E6C8).withOpacity(0.6)
                              : const Color(0xFF3B2E1A).withOpacity(0.6),
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // TODO: Implement forgot password
                      },
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
                    onPressed: loading ? null : loginUser,
                    child: loading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                isDark
                                    ? const Color(0xFFF5E6C8)
                                    : const Color(0xFF3B2E1A),
                              ),
                            ),
                          )
                        : Text(
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

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}
