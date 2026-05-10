// lib/core/utils/scroll_utils.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quark_web/core/constants/app_colors.dart';

//*- Desplazamiento de sección -*\\
void scrollToSection(GlobalKey key) {
  final context = key.currentContext;
  if (context != null) {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}
//*- Desplazamiento de sección -*\\

//*- Botón genérico de header -*\\
Widget buildHeaderButton(String title, GlobalKey key) {
  return TextButton(
    onPressed: () => scrollToSection(key),
    child: Text(
      title,
      style: GoogleFonts.roboto(
        fontSize: 18,
        color: color0,
      ),
    ),
  );
}
//*- Botón genérico de header -*\\
