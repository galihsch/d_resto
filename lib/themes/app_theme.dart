import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light mode colors
  static const Color _lightPrimaryColor = Color(0xFFFA6B52);
  static const Color _lightSecondaryColor = Color(0xFFFF9E72);
  static const Color _lightBackgroundColor = Color(0xFFF6F8FB);
  static const Color _lightSurfaceColor = Colors.white;
  static const Color _lightCardColor = Colors.white;
  static const Color _lightTextPrimaryColor = Color(0xFF212121);
  static const Color _lightTextSecondaryColor = Color(0xFF757575);
  static const Color _lightErrorColor = Color(0xFFD32F2F);

  // Dark mode colors
  static const Color _darkPrimaryColor = Color(0xFFFA6B52);
  static const Color _darkSecondaryColor = Color(0xFFFF9E72);
  static const Color _darkBackgroundColor = Color(0xFF121212);
  static const Color _darkSurfaceColor = Color(0xFF1E1E1E);
  static const Color _darkCardColor = Color(0xFF242424);
  static const Color _darkTextPrimaryColor = Color(0xFFF5F5F5);
  static const Color _darkTextSecondaryColor = Color(0xFFB0B0B0);
  static const Color _darkErrorColor = Color(0xFFEF5350);

  // Font families
  static final TextTheme _textTheme = TextTheme(
    displayLarge: GoogleFonts.raleway(fontWeight: FontWeight.w700),
    displayMedium: GoogleFonts.raleway(fontWeight: FontWeight.w700),
    displaySmall: GoogleFonts.raleway(fontWeight: FontWeight.w700),
    headlineLarge: GoogleFonts.raleway(fontWeight: FontWeight.w700),
    headlineMedium: GoogleFonts.raleway(fontWeight: FontWeight.w600),
    headlineSmall: GoogleFonts.raleway(fontWeight: FontWeight.w600),
    titleLarge: GoogleFonts.raleway(fontWeight: FontWeight.w600),
    titleMedium: GoogleFonts.raleway(fontWeight: FontWeight.w500),
    titleSmall: GoogleFonts.raleway(fontWeight: FontWeight.w500),
    bodyLarge: GoogleFonts.poppins(),
    bodyMedium: GoogleFonts.poppins(),
    bodySmall: GoogleFonts.poppins(),
    labelLarge: GoogleFonts.poppins(fontWeight: FontWeight.w500),
    labelMedium: GoogleFonts.poppins(),
    labelSmall: GoogleFonts.poppins(),
  );

  // Light theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: _lightPrimaryColor,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: _lightPrimaryColor,
      onPrimary: Colors.white,
      secondary: _lightSecondaryColor,
      onSecondary: Colors.white,
      error: _lightErrorColor,
      onError: Colors.white,
      background: _lightBackgroundColor,
      onBackground: _lightTextPrimaryColor,
      surface: _lightSurfaceColor,
      onSurface: _lightTextPrimaryColor,
    ),
    scaffoldBackgroundColor: _lightBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: _lightPrimaryColor,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: _lightCardColor,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _lightPrimaryColor,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _lightPrimaryColor,
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _lightPrimaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _lightErrorColor, width: 2),
      ),
      hintStyle: GoogleFonts.poppins(
        color: _lightTextSecondaryColor,
        fontSize: 14,
      ),
    ),
    textTheme: _textTheme.apply(
      bodyColor: _lightTextPrimaryColor,
      displayColor: _lightTextPrimaryColor,
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE0E0E0),
      thickness: 1,
      space: 1,
    ),
    iconTheme: const IconThemeData(color: _lightTextPrimaryColor, size: 24),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _lightSurfaceColor,
      selectedItemColor: _lightPrimaryColor,
      unselectedItemColor: _lightTextSecondaryColor,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),
  );

  // Dark theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: _darkPrimaryColor,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: _darkPrimaryColor,
      onPrimary: Colors.white,
      secondary: _darkSecondaryColor,
      onSecondary: Colors.white,
      error: _darkErrorColor,
      onError: Colors.white,
      background: _darkBackgroundColor,
      onBackground: _darkTextPrimaryColor,
      surface: _darkSurfaceColor,
      onSurface: _darkTextPrimaryColor,
    ),
    scaffoldBackgroundColor: _darkBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: _darkSurfaceColor,
      foregroundColor: _darkTextPrimaryColor,
      centerTitle: true,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: _darkCardColor,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _darkPrimaryColor,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _darkPrimaryColor,
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkCardColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _darkPrimaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _darkErrorColor, width: 2),
      ),
      hintStyle: GoogleFonts.poppins(
        color: _darkTextSecondaryColor,
        fontSize: 14,
      ),
    ),
    textTheme: _textTheme.apply(
      bodyColor: _darkTextPrimaryColor,
      displayColor: _darkTextPrimaryColor,
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF424242),
      thickness: 1,
      space: 1,
    ),
    iconTheme: const IconThemeData(color: _darkTextPrimaryColor, size: 24),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _darkSurfaceColor,
      selectedItemColor: _darkPrimaryColor,
      unselectedItemColor: _darkTextSecondaryColor,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
