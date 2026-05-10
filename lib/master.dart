import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//*- Paleta de colores -*\\
const Color color0 = Colors.black;
const Color color1 = Colors.white;
const Color color2 = Color(0xFF68904D);
const Color color3 = Color(0xFFDA6A00);
//*- Paleta de colores -*\\

//*- Determina el idioma de la página -*\\
ValueNotifier<String> lenguaje = ValueNotifier<String>('ES');
List<String> languages = ['EN', 'ES'];
//*- Determina el idioma de la página -*\\

//*- Cambia el idioma de la página -*\\
void changeLanguage(String newLanguage) {
  lenguaje.value = newLanguage;
}
//*- Cambia el idioma de la página -*\\

//*- Boton Generico -*\\
Widget buildHeaderButton(String title, GlobalKey key) {
  return TextButton(
    onPressed: () {
      scrollToSection(key);
    },
    child: Text(
      title,
      style: GoogleFonts.roboto(
        fontSize: 18,
        color: color0,
      ),
    ),
  );
}
//*- Boton Generico -*\\

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