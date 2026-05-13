// lib/core/utils/html_utils.dart
import 'package:web/web.dart' as web;

// ---------------------------------------------------------------------------
// Idioma del documento HTML
// ---------------------------------------------------------------------------

/// Actualiza el atributo [lang] del elemento <html>.
/// Esencial para SEO y accesibilidad al cambiar de idioma en runtime.
void updateHtmlLang(String localeCode) {
  final el = web.document.documentElement;
  if (el != null) {
    (el as web.HTMLElement).lang = localeCode.toLowerCase();
  }
}

// ---------------------------------------------------------------------------
// SEO meta tags dinámicos por idioma
// ---------------------------------------------------------------------------

/// Actualiza title, description, og:* y canonical según el idioma activo.
/// Llamar en initState y cada vez que cambie el idioma.
void updateSeoMeta(String localeCode) {
  final isEs = localeCode == 'ES';

  final title =
      isEs
          ? 'Quarks Studio — Apps Flutter a medida para tu negocio'
          : 'Quarks Studio — Custom Flutter Apps for Your Business';

  final description =
      isEs
          ? 'En Quarks Studio desarrollamos apps móviles, web y software a medida con Flutter y Firebase. Transformamos tus ideas en soluciones digitales reales.'
          : 'At Quarks Studio we build mobile apps, web apps and custom software with Flutter & Firebase. We turn your ideas into real digital solutions.';

  final canonical =
      isEs ? 'https://quarks-studio.com/es/' : 'https://quarks-studio.com/';

  // <title>
  web.document.title = title;

  // <meta name="description">
  _setMetaByName('description', description);

  // Open Graph
  _setMetaByProperty('og:title', title);
  _setMetaByProperty('og:description', description);
  _setMetaByProperty('og:url', canonical);
  _setMetaByProperty('og:locale', isEs ? 'es_AR' : 'en_US');

  // Twitter Card
  _setMetaByName('twitter:title', title);
  _setMetaByName('twitter:description', description);

  // Canonical
  _setLinkHref('canonical', canonical);
}

// ---------------------------------------------------------------------------
// Helpers privados
// ---------------------------------------------------------------------------

void _setMetaByName(String name, String content) {
  final el = web.document.querySelector('meta[name="$name"]');
  if (el != null) {
    (el as web.HTMLMetaElement).content = content;
  }
}

void _setMetaByProperty(String property, String content) {
  final el = web.document.querySelector('meta[property="$property"]');
  if (el != null) {
    (el as web.HTMLMetaElement).content = content;
  }
}

void _setLinkHref(String rel, String href) {
  final el = web.document.querySelector('link[rel="$rel"]');
  if (el != null) {
    (el as web.HTMLLinkElement).href = href;
  }
}