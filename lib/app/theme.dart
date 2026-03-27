import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final baseColorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF5B52E8),
      brightness: Brightness.light,
      primary: const Color(0xFF5B52E8),
      secondary: const Color(0xFF0D9488),
      tertiary: const Color(0xFFF43F5E), // Expressive Tertiary
      surface: const Color(0xFFFBFBFF),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: baseColorScheme.copyWith(
        surfaceContainerLow: const Color(0xFFF3F3FF),
        surfaceContainer: const Color(0xFFEEEEFF),
        surfaceContainerHigh: const Color(0xFFE5E5FF),
      ),
      scaffoldBackgroundColor: const Color(0xFFF8F7FF),
      textTheme: _expressiveTextTheme(baseColorScheme.onSurface),
      dividerColor: const Color(0xFFE0E7FF),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), // Extra-Large
        color: const Color(0xFFFFFFFF),
      ),
    );
  }

  static ThemeData get darkTheme {
    final baseColorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF6C63FF),
      brightness: Brightness.dark,
      primary: const Color(0xFF6C63FF),
      secondary: const Color(0xFF2DD4BF),
      tertiary: const Color(0xFFFB7185), // Expressive Tertiary
      surface: const Color(0xFF0F0F1A),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: baseColorScheme.copyWith(
        surfaceContainerLow: const Color(0xFF16162A),
        surfaceContainer: const Color(0xFF1A1A2E),
        surfaceContainerHigh: const Color(0xFF22223B),
      ),
      scaffoldBackgroundColor: const Color(0xFF0F0F1A),
      textTheme: _expressiveTextTheme(baseColorScheme.onSurface),
      dividerColor: const Color(0xFF2D2D4E),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), // Extra-Large
        color: const Color(0xFF1A1A2E),
      ),
    );
  }

  static TextTheme _expressiveTextTheme(Color color) {
    return TextTheme(
      // Emphasized Styles (Headlines/Display)
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 57, 
        fontWeight: FontWeight.w800, 
        letterSpacing: -1.0,
        color: color,
      ),
      displayMedium: GoogleFonts.plusJakartaSans(
        fontSize: 45, 
        fontWeight: FontWeight.w800, 
        letterSpacing: -0.5,
        color: color,
      ),
      displaySmall: GoogleFonts.plusJakartaSans(
        fontSize: 36, 
        fontWeight: FontWeight.w700, 
        color: color,
      ),
      headlineLarge: GoogleFonts.plusJakartaSans(
        fontSize: 32, 
        fontWeight: FontWeight.w700, 
        color: color,
      ),
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontSize: 28, 
        fontWeight: FontWeight.w700, 
        color: color,
      ),
      headlineSmall: GoogleFonts.plusJakartaSans(
        fontSize: 24, 
        fontWeight: FontWeight.w600, 
        color: color,
      ),

      // Baseline Styles (Body/Label/Title)
      titleLarge: GoogleFonts.plusJakartaSans(
        fontSize: 22, 
        fontWeight: FontWeight.w600, 
        color: color,
      ),
      titleMedium: GoogleFonts.plusJakartaSans(
        fontSize: 16, 
        fontWeight: FontWeight.w600, 
        letterSpacing: 0.15,
        color: color,
      ),
      titleSmall: GoogleFonts.plusJakartaSans(
        fontSize: 14, 
        fontWeight: FontWeight.w600, 
        letterSpacing: 0.1,
        color: color,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16, 
        fontWeight: FontWeight.w400, 
        letterSpacing: 0.5,
        color: color,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14, 
        fontWeight: FontWeight.w400, 
        letterSpacing: 0.25,
        color: color,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12, 
        fontWeight: FontWeight.w400, 
        letterSpacing: 0.4,
        color: color,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14, 
        fontWeight: FontWeight.w600, 
        letterSpacing: 0.1,
        color: color,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12, 
        fontWeight: FontWeight.w600, 
        letterSpacing: 0.5,
        color: color,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11, 
        fontWeight: FontWeight.w500, 
        letterSpacing: 0.5,
        color: color,
      ),
    );
  }
}
