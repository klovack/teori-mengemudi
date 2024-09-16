import 'package:flutter/material.dart';
import 'package:roadcognizer/theme/fonts.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Colors.blueGrey[900]!,
    onPrimary: Colors.white,
    secondary: Colors.orangeAccent,
    onSecondary: Colors.black,
    background: Colors.grey[900]!,
    onBackground: Colors.white,
    surface: Colors.grey[800]!,
    onSurface: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blueGrey[900],
    foregroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodyLarge: Fonts.getSecondary(
      ts: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
    bodyMedium: Fonts.getSecondary(
      ts: const TextStyle(
        color: Colors.white70,
        fontSize: 14,
      ),
    ),
    titleLarge: Fonts.getPrimary(
      ts: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    titleMedium: Fonts.getPrimary(
      ts: const TextStyle(
        color: Colors.white70,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueGrey[700],
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 16),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.orangeAccent,
    foregroundColor: Colors.white,
  ),
  iconTheme: const IconThemeData(
    color: Colors.orangeAccent,
  ),
);
