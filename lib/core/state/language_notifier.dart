// lib/core/state/language_notifier.dart
import 'package:flutter/foundation.dart';

//*- Estado global del idioma de la app -*\\
final ValueNotifier<String> lenguaje = ValueNotifier<String>('ES');
const List<String> languages = ['EN', 'ES'];

void changeLanguage(String newLanguage) {
  lenguaje.value = newLanguage;
}
//*- Estado global del idioma de la app -*\\
