import 'package:flutter/material.dart';

/// Colour palette used across the whole website.
class AppColors {
  AppColors._();

  static const Color navy = Color(0xFF102A43);
  static const Color primary = Color(0xFF1565C0);
  static const Color lightBlue = Color(0xFFEAF3FF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF263238);
  static const Color grey = Color(0xFFF5F7FA);

  // Supporting shades (derived from the palette above).
  static const Color textMuted = Color(0xFF546E7A);
  static const Color border = Color(0xFFDDE6EF);
}

/// Material 3 theme for the website.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      surface: Colors.white,
    );

    final RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    );
    const EdgeInsets buttonPadding =
        EdgeInsets.symmetric(horizontal: 26, vertical: 18);
    const TextStyle buttonText =
        TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.white,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: buttonPadding,
          textStyle: buttonText,
          shape: buttonShape,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          padding: buttonPadding,
          textStyle: buttonText,
          shape: buttonShape,
        ),
      ),
    );
  }
}
