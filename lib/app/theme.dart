import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF8F7FF),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF5B52E8),
        secondary: Color(0xFF0D9488),
        surface: Color(0xFFFFFFFF),
        error: Color(0xFFDC2626),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF1E1B4B),
        onError: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.plusJakartaSans(fontSize: 36, fontWeight: FontWeight.w700, color: const Color(0xFF1E1B4B)),
        headlineLarge: GoogleFonts.plusJakartaSans(fontSize: 26, fontWeight: FontWeight.w600, color: const Color(0xFF1E1B4B)),
        headlineMedium: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w500, color: const Color(0xFF1E1B4B)),
        bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: const Color(0xFF1E1B4B)),
        bodyMedium: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w400, color: const Color(0xFF1E1B4B)),
        labelMedium: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, color: const Color(0xFF6B7280)),
      ),
      dividerColor: const Color(0xFFE0E7FF),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0F0F1A),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF6C63FF),
        secondary: Color(0xFF2DD4BF),
        surface: Color(0xFF1A1A2E), // Surface Elevated: #22223B
        error: Color(0xFFFF6B6B),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Color(0xFFF0EFFF),
        onError: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.plusJakartaSans(fontSize: 36, fontWeight: FontWeight.w700, color: const Color(0xFFF0EFFF)),
        headlineLarge: GoogleFonts.plusJakartaSans(fontSize: 26, fontWeight: FontWeight.w600, color: const Color(0xFFF0EFFF)),
        headlineMedium: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w500, color: const Color(0xFFF0EFFF)),
        bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: const Color(0xFFF0EFFF)),
        bodyMedium: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w400, color: const Color(0xFFF0EFFF)),
        labelMedium: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, color: const Color(0xFF9CA3AF)),
      ),
      dividerColor: const Color(0xFF2D2D4E),
    );
  }
}
