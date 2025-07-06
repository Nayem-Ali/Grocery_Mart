import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xFF53B175), // Greenish tone from Figma
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF53B175),
      secondary: const Color(0xFFFFC107), // Optional yellow/orange accent
      background: Colors.white,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onBackground: Colors.black,
      onSurface: Colors.black,
    ),
    textTheme: const TextTheme(
      // Display
      displayLarge: TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 57,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 45,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 36,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),

      // Headlines
      headlineLarge: TextStyle(
        // already defined
        fontFamily: 'Gilroy',
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),

      // Titles
      titleLarge: TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        // already defined
        fontFamily: 'Gilroy',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),

      // Body
      bodyLarge: TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        // already defined
        fontFamily: 'Gilroy',
        fontSize: 14,
        color: Colors.black87,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 12,
        color: Colors.black54,
      ),

      // Labels
      labelLarge: TextStyle(
        // already defined
        fontFamily: 'Gilroy',
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFF53B175),
      ),
      labelMedium: TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFF53B175),
      ),
      labelSmall: TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Color(0xFF53B175),
      ),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF53B175),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF2F3F2),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: const TextStyle(color: Colors.grey),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    iconTheme: const IconThemeData(color: Colors.black87),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF53B175),
      unselectedItemColor: Colors.grey.shade600,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      type: BottomNavigationBarType.fixed,
      elevation: 10,
    ),
  );
}
