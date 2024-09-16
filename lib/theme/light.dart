import 'package:flutter/material.dart';
import 'package:roadcognizer/theme/fonts.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: Colors.orangeAccent,
    onSecondary: Colors.white,
    background: Colors.grey[100]!,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodyLarge: Fonts.getSecondary(
      ts: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
    ),
    bodyMedium: Fonts.getSecondary(
      ts: const TextStyle(
        color: Colors.black54,
        fontSize: 14,
      ),
    ),
    titleLarge: Fonts.getPrimary(
      ts: const TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    titleMedium: Fonts.getPrimary(
      ts: const TextStyle(
        color: Colors.black54,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 16),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.orangeAccent,
    foregroundColor: Colors.white,
  ),
  iconTheme: const IconThemeData(
    color: Colors.blue,
  ),
);
