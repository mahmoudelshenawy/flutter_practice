import 'package:flutter/material.dart';

const COLOR_PRIMARY = Colors.deepOrangeAccent;
const COLOR_ACCENT = Colors.orange;

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: COLOR_PRIMARY,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: COLOR_ACCENT,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
      shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
      backgroundColor: WidgetStateProperty.all<Color>(COLOR_ACCENT),
    ),
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: COLOR_PRIMARY,
      foregroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.grey),
  inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1)),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.all<Color>(Colors.grey),
    thumbColor: WidgetStateProperty.all<Color>(Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide.none),
    filled: true,
    fillColor: Colors.grey.withOpacity(0.1),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
      shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
      backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
      overlayColor: WidgetStateProperty.all<Color>(Colors.black26),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: COLOR_ACCENT,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40),
    ),
  ),
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[800],
      foregroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.grey),
);
