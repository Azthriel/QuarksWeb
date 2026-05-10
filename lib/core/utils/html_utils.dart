// lib/core/utils/html_utils.dart
import 'package:web/web.dart' as web;

/// Actualiza el atributo [lang] del elemento <html> del documento.
/// Esencial para SEO y accesibilidad al cambiar de idioma en runtime.
/// [localeCode] debe ser 'EN' o 'ES' (se convierte a minúscula internamente).
void updateHtmlLang(String localeCode) {
  final el = web.document.documentElement;
  if (el != null) {
    (el as web.HTMLElement).lang = localeCode.toLowerCase();
  }
}