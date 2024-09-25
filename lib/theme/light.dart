import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roadcognizer/theme/brand_colors.dart';
import 'package:roadcognizer/theme/fonts.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: BrandColors.red,
    onPrimary: Colors.white,
    secondary: BrandColors.blue,
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: BrandColors.red,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: BrandColors.darkBlue,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
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
  dropdownMenuTheme: const DropdownMenuThemeData(
    menuStyle: MenuStyle(
      alignment: Alignment(-1.25, 1),
      padding:
          WidgetStatePropertyAll(EdgeInsets.only(right: 10, top: 8, bottom: 8)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(
            color: Colors.red,
            width: 2,
            strokeAlign: -4,
          ),
        ),
      ),
      elevation: WidgetStatePropertyAll(4),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      outlineBorder: BorderSide.none,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
  ),
);
