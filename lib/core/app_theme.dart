import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static InputDecorationTheme _inputTheme(Color fill, Color border) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fill,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      hintStyle: const TextStyle(color: AppColors.textSoft),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }

  static TextTheme _textTheme(Color title, Color body) {
    return TextTheme(
      headlineLarge: GoogleFonts.outfit(
        fontSize: 30,
        fontWeight: FontWeight.w800,
        color: title,
      ),
      titleLarge: GoogleFonts.outfit(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: title,
      ),
      titleMedium: GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: title,
      ),
      bodyMedium: GoogleFonts.dmSans(fontSize: 14, color: body),
    );
  }

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
      ),
      textTheme: _textTheme(AppColors.navy, AppColors.textSoft),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.navy),
      ),
      inputDecorationTheme: _inputTheme(Colors.white, const Color(0xFFE6E3FA)),
    );
  }

  static ThemeData get dark {
    const bg = Color(0xFF12122B);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        primary: AppColors.primaryLight,
      ),
      textTheme: _textTheme(Colors.white, Colors.white70),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: _inputTheme(
        const Color(0xFF1E1E45),
        const Color(0xFF2E2E5E),
      ),
    );
  }
}
