import 'package:flutter/material.dart';
import 'package:roadcognizer/theme/brand_colors.dart';
import 'package:roadcognizer/theme/fonts.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: const Color(0xFFFFCA35),
    onSecondary: Colors.white,
    background: Colors.grey[100]!,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    inverseSurface: const Color(0xFF003997),
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
      backgroundColor: BrandColors.blue,
      foregroundColor: BrandColors.white,
      textStyle: const TextStyle(fontSize: 16),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: BrandColors.white,
    foregroundColor: BrandColors.darkBlue,
    elevation: 0,
  ),
  iconTheme: const IconThemeData(
    color: Colors.blue,
  ),
  scaffoldBackgroundColor: BrandColors.white,
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.transparent,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    indicatorColor: BrandColors.white,
    indicatorShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(
        color: BrandColors.red,
        width: 2,
        strokeAlign: -2,
      ),
    ),
    labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Fonts.getSecondary(color: BrandColors.white);
      }
      return Fonts.getSecondary(color: BrandColors.white.withOpacity(0.5));
    }),
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(color: BrandColors.red);
      }
      return IconThemeData(color: BrandColors.white.withOpacity(0.5));
    }),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: BrandColors.red,
    surfaceTintColor: BrandColors.red,
  ),
);
