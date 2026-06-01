import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quark_web/core/constants/app_themes.dart';
import 'package:quark_web/core/router/app_router.dart';
import 'package:quark_web/core/state/theme_notifier.dart';
import 'package:quark_web/firebase_options.dart';
import 'package:quarks_version_checker/quarks_version_checker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  usePathUrlStrategy();
    await GoogleFonts.pendingFonts([
    GoogleFonts.poppins(),
    GoogleFonts.poppins(fontWeight: FontWeight.w700),
    GoogleFonts.poppins(fontWeight: FontWeight.w600),
    GoogleFonts.poppins(fontWeight: FontWeight.w400),
  ]);
  try {
    await AppVersionChecker.instance.start();
  } catch (_) {}
  if (kIsWeb) SemanticsBinding.instance.ensureSemantics();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: temaApp,
      builder: (_, mode, __) {
        return MaterialApp.router(
          title: 'Quarks Studio',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: mode,
          routerConfig: buildAppRouter(),
        );
      },
    );
  }
}
