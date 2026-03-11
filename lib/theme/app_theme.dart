import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color Palette - Dark Mode First
  static const Color primaryBg = Color(0xFF0a0a0f);
  static const Color secondaryBg = Color(0xFF12121a);
  static const Color cardBg = Color(0xFF1a1a2e);
  static const Color accentPrimary = Color(0xFF6366f1);
  static const Color accentSecondary = Color(0xFF8b5cf6);
  static const Color accentGradientStart = Color(0xFF6366f1);
  static const Color accentGradientEnd = Color(0xFF8b5cf6);
  static const Color textPrimary = Color(0xFFfafafa);
  static const Color textSecondary = Color(0xFFa1a1aa);
  static const Color textMuted = Color(0xFF71717a);
  static const Color borderColor = Color(0xFF27272a);
  static const Color successGreen = Color(0xFF22c55e);
  static const Color warningOrange = Color(0xFFf97316);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [accentGradientStart, accentGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient subtleGradient = LinearGradient(
    colors: [Color(0xFF1a1a2e), Color(0xFF0f0f1a)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Box Shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];

  static List<BoxShadow> accentGlow = [
    BoxShadow(
      color: accentPrimary.withOpacity(0.3),
      blurRadius: 30,
      spreadRadius: -5,
    ),
  ];

  // Border Radius
  static BorderRadius cardRadius = BorderRadius.circular(16);
  static BorderRadius buttonRadius = BorderRadius.circular(12);
  static BorderRadius chipRadius = BorderRadius.circular(8);

  // Theme Data
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: primaryBg,
      colorScheme: const ColorScheme.dark(
        primary: accentPrimary,
        secondary: accentSecondary,
        surface: secondaryBg,
        error: Color(0xFFef4444),
        onPrimary: textPrimary,
        onSecondary: textPrimary,
        onSurface: textPrimary,
      ),
      textTheme: GoogleFonts.interTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.w800,
            color: textPrimary,
            letterSpacing: -2,
            height: 1.1,
          ),
          displayMedium: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            color: textPrimary,
            letterSpacing: -1.5,
            height: 1.2,
          ),
          displaySmall: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: -1,
          ),
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          headlineSmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textPrimary,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: textSecondary,
            height: 1.7,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textSecondary,
            height: 1.6,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textMuted,
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          labelMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textSecondary,
          ),
          labelSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textMuted,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentPrimary,
          foregroundColor: textPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: buttonRadius),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: buttonRadius),
          side: const BorderSide(color: borderColor, width: 1.5),
        ),
      ),
      cardTheme: CardThemeData(
        color: cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: cardRadius),
      ),
      dividerTheme: const DividerThemeData(
        color: borderColor,
        thickness: 1,
      ),
    );
  }
}

// Responsive breakpoints
class Breakpoints {
  static const double mobile = 480;
  static const double tablet = 768;
  static const double desktop = 1024;
  static const double wide = 1280;
}

// Responsive helper
extension ResponsiveContext on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < Breakpoints.tablet;
  bool get isTablet =>
      MediaQuery.of(this).size.width >= Breakpoints.tablet &&
      MediaQuery.of(this).size.width < Breakpoints.desktop;
  bool get isDesktop => MediaQuery.of(this).size.width >= Breakpoints.desktop;
  bool get isWide => MediaQuery.of(this).size.width >= Breakpoints.wide;
  
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  
  double get contentPadding => isMobile ? 20 : (isTablet ? 40 : 80);
  double get maxContentWidth => 1200.0;
}
