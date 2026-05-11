// lib/core/state/theme_notifier.dart
import 'package:flutter/material.dart';

//*- Estado global del tema -*\\
final ValueNotifier<ThemeMode> temaApp = ValueNotifier<ThemeMode>(ThemeMode.light);

void toggleTheme() {
  temaApp.value =
      temaApp.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
}

bool get isDarkMode => temaApp.value == ThemeMode.dark;
//*- Estado global del tema -*\\