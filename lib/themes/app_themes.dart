import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFFA3B18A),
    scaffoldBackgroundColor: const Color(0xFFF9FAF8),
    cardColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFA3B18A),
      secondary: Color(0xFFD4AF37),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: const Color(0xFF1E1E1E),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF556B2F)),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF1E1E1E),
      elevation: 1,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF8AA29E),
    scaffoldBackgroundColor: const Color(0xFF1C1C1C),
    cardColor: const Color(0xFF2A2A2A),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF8AA29E),
      secondary: Color(0xFFFFD700),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: const Color(0xFFF5F5F5),
    ),
    iconTheme: const IconThemeData(color: Color(0xFFFFD700)),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF2A2A2A),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
}
