import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

Widget buildHeaderButton(String title, GlobalKey key, BuildContext context) {
  return TextButton(
    onPressed: () => scrollToSection(key),
    child: Text(
      title,
      style: GoogleFonts.roboto(
        fontSize: 18,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    ),
  );
}
