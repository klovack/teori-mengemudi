import 'package:flutter/material.dart';
import 'package:roadcognizer/theme/brand_colors.dart';
import 'package:roadcognizer/theme/fonts.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: BrandColors.red,
    onPrimary: BrandColors.white,
    secondary: BrandColors.yellow,
    onSecondary: Colors.black,
    background: Colors.grey[900]!,
    onBackground: Colors.white,
    surface: BrandColors.blue,
    onSurface: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: BrandColors.yellow,
    scrolledUnderElevation: 0,
  ),
  textTheme: TextTheme(
    bodyLarge: Fonts.getSecondary(
      ts: const TextStyle(
        color: Color(0xFFFFCA35),
        fontSize: 16,
      ),
    ),
    bodyMedium: Fonts.getSecondary(
      ts: const TextStyle(
        color: Color(0xFFFFCA35),
        fontSize: 14,
      ),
    ),
    titleLarge: Fonts.getPrimary(
      ts: const TextStyle(
        color: Color(0xFFFFCA35),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    titleMedium: Fonts.getPrimary(
      ts: const TextStyle(
        color: Color(0xFFFFCA35),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: BrandColors.white,
      foregroundColor: BrandColors.blue,
      textStyle: const TextStyle(fontSize: 16),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: BrandColors.blue,
    foregroundColor: BrandColors.white,
  ),
  iconTheme: const IconThemeData(
    color: BrandColors.white,
  ),
  scaffoldBackgroundColor: BrandColors.darkBlue,
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.transparent,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    indicatorColor: BrandColors.darkBlue,
    indicatorShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(
        color: BrandColors.blue,
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
        return const IconThemeData(color: BrandColors.white);
      }
      return IconThemeData(color: BrandColors.white.withOpacity(0.5));
    }),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: BrandColors.blue,
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
            color: BrandColors.red,
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
