// lib/core/router/app_router.dart
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:quark_web/features/home/screens/home_screen.dart';
import 'package:quark_web/shared/widgets/error_404_page.dart';

final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

GoRouter buildAppRouter() {
  return GoRouter(
    initialLocation: '/',
    redirect: (BuildContext context, GoRouterState state) {
      final path = state.uri.path;
      if (path == '/') {
        final lang = PlatformDispatcher.instance.locale.languageCode;
        // Solo redirigir a /es si el browser está en español.
        // Retornar null (no redirigir) para inglés evita el loop infinito.
        return lang == 'es' ? '/es' : null;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            HomeScreen(analytics: _analytics, localeCode: 'EN'),
      ),
      GoRoute(
        path: '/es',
        builder: (context, state) =>
            HomeScreen(analytics: _analytics, localeCode: 'ES'),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
}
