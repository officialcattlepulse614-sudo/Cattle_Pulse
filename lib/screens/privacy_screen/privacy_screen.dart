import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // ✨ Gold Accent color matching project theme
    const goldAccent = Color(0xFFB87333);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFFFFBF5),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: isDark ? const Color(0xFF1C1C1C) : const Color(0xFFF5E8C8),
        title: Text(
          tr('privacy_title'),
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : goldAccent, // 🌟 Highlight line
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          tr('privacy_description'),
          style: GoogleFonts.poppins(
            fontSize: 16,
            height: 1.6,
            color: isDark ? Colors.white70 : const Color(0xFF3A2E1F),
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
