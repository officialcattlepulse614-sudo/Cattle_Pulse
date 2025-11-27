// lib/screens/menu_screens/settings_screen/help_support_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  Future<void> _launchWebsite() async {
    final url = Uri.parse("https://www.cattlepulse.com");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Transparent system bars (same as About App)
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
            // ----------------------------
            // Floating AppBar (IDENTICAL)
            // ----------------------------
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
                          'Help & Support',
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

            // ----------------------------
            // Main content (MATCHED)
            // ----------------------------
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    const SizedBox(height: 16),

                    // Title
                    Text(
                      "We're here to help",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? const Color(0xFFF5E6C8)
                            : const Color(0xFF3B2E1A),
                      ),
                    ),

                    const SizedBox(height: 8),
                    Text(
                      "If you are facing any issue or have suggestions, feel free to reach out.",
                      style: theme.textTheme.bodyMedium,
                    ),

                    const SizedBox(height: 24),

                    // Contact Card
                    Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(12),
                      color:
                          isDark ? Colors.grey[900] : const Color(0xFFFFF8E7),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.email_outlined,
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black87),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    "support@cattlepulse.com",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(Icons.language_outlined,
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black87),
                                const SizedBox(width: 12),
                                InkWell(
                                  onTap: _launchWebsite,
                                  child: Text(
                                    "www.cattlepulse.com",
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      "Response Time",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Our support team usually responds within 24 hours.",
                      style: theme.textTheme.bodyMedium,
                    ),

                    const SizedBox(height: 32),

                    Center(
                      child: Text(
                        "Thank you for using CattlePulse!",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
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
