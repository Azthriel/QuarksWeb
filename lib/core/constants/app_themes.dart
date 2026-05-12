// lib/core/constants/app_themes.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quark_web/core/constants/app_colors.dart';

const Color _darkBg = Color(0xFF121212);
const Color _darkSurface = Color(0xFF1E1E1E);
const Color _darkText = Color(0xFFF5F5F5);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: color3,
    secondary: color2,
    surface: color1,
    onSurface: color0,
  ),
  scaffoldBackgroundColor: color1,
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: color3,
    selectionColor: color3.withAlpha(70),
    selectionHandleColor: color3,
  ),
  tabBarTheme: const TabBarThemeData(indicatorColor: color3),
  dividerColor: color0,
  drawerTheme: const DrawerThemeData(backgroundColor: color1),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: color3,
    secondary: color2,
    surface: _darkSurface,
    onSurface: _darkText,
  ),
  scaffoldBackgroundColor: _darkBg,
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: color3,
    selectionColor: color3.withAlpha(70),
    selectionHandleColor: color3,
  ),
  tabBarTheme: const TabBarThemeData(indicatorColor: color3),
  dividerColor: _darkText,
  drawerTheme: const DrawerThemeData(backgroundColor: _darkSurface),
);