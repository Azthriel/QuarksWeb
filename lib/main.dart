// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:quark_web/core/constants/app_colors.dart';
import 'package:quark_web/core/router/app_router.dart';
import 'package:quark_web/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  usePathUrlStrategy();
  if (kIsWeb) {
    SemanticsBinding.instance.ensureSemantics();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        ),
        tabBarTheme: const TabBarThemeData(indicatorColor: color3),
      ),
      routerConfig: buildAppRouter(),
    );
  }
}
