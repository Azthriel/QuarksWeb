// lib/main.dart
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:go_router/go_router.dart';
import 'package:quark_web/firebase_options.dart';
import 'package:quark_web/master.dart';
import 'package:quark_web/widgets/error404.dart';
import 'screens/home_screen.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  usePathUrlStrategy();
  if (kIsWeb) {
    SemanticsBinding.instance.ensureSemantics();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  MyApp({super.key});

  final router = GoRouter(
    initialLocation: '/',
    redirect: (BuildContext context, GoRouterState state) {
      final path = state.uri.path;
      if (path == '/') {
        final lang = PlatformDispatcher.instance.locale.languageCode;
        return lang == 'es' ? '/es' : '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            HomeScreen(analytics: analytics, localeCode: 'EN'),
      ),
      GoRoute(
        path: '/es',
        builder: (context, state) =>
            HomeScreen(analytics: analytics, localeCode: 'ES'),
      ),
      GoRoute(
        path: '/es/',
        builder: (context, state) =>
            HomeScreen(analytics: analytics, localeCode: 'ES'),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Quarks Studio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: color3,
          selectionColor: color3.withAlpha(70),
          selectionHandleColor: color3,
        ), tabBarTheme: const TabBarThemeData(indicatorColor: color3),
      ),
      routerConfig: router,
    );
  }
}
