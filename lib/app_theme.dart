import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF5669FF);
  static const Color backgroundLight = Color(0xFFF2FEFF);
  static const Color backgroundDark = Color(0xFF101127);
  static const Color red = Color(0xFFFF5659);
  static const Color grey = Color(0xFF7B7B7B);
  static const Color black = Color(0xFF1C1C1C);
  static const Color white = Color(0xFFF4EBDC);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primary,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: white,
      unselectedItemColor: white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
      shape: CircleBorder(),
      // shape: CircleBorder(side: BorderSide(width: 5, color: white)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: grey,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.circular(16),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: red),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: red),
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: white,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: white,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: black,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData();
}
