import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quark_web/lenguajes.dart';
import '../master.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  const Header({
    super.key,
    required this.scrollController,
    required this.keyIntroduction,
    required this.keyServices,
    required this.keyPortfolio,
    required this.keyContact,
    required this.keyTools,
    required this.onChangeLanguage,
  });

  final ScrollController scrollController;
  final GlobalKey keyIntroduction;
  final GlobalKey keyServices;
  final GlobalKey keyPortfolio;
  final GlobalKey keyContact;
  final GlobalKey keyTools;
  final void Function(String) onChangeLanguage;

  @override
  HeaderState createState() => HeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: widget.preferredSize,
      child: Container(
        color: color1,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              return _buildLargeScreen();
            } else {
              return _buildSmallScreen(context);
            }
          },
        ),
      ),
    );
  }

  //*- Pantallas grandes -*\\
  Widget _buildLargeScreen() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 1200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/isologo.png',
              height: 60,
            ),
            const Expanded(child: SizedBox()),
            ValueListenableBuilder<String>(
              valueListenable: lenguaje,
              builder: (context, value, child) {
                return Row(
                  children: [
                    buildHeaderButton(nosotros(value), widget.keyIntroduction),
                    buildHeaderButton(servicios(value), widget.keyServices),
                    buildHeaderButton(herramientas(value), widget.keyTools),
                    buildHeaderButton(clientes(value), widget.keyPortfolio),
                    buildHeaderButton(contacto(value), widget.keyContact),
                    buildLanguageMenu(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  //*- Pantallas grandes -*\\

  //*- Pantallas pequeñas -*\\
  Widget _buildSmallScreen(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/isologo.png',
              height: 50,
            ),
          ],
        ),
        const Spacer(),
        buildLanguageMenu(),
        IconButton(
          icon: const Icon(Icons.menu, color: color0, size: 30),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ),
      ],
    );
  }
  //*- Pantallas pequeñas -*\\

  //*- Dropdown de idioma -*\\
  Widget buildLanguageMenu() {
    return PopupMenuButton<String>(
      onSelected: (String language) {
        if (lenguaje.value != language) {
          changeLanguage(language);
          widget.onChangeLanguage(language);
        }
      },
      icon: Row(
        children: [
          const Icon(Icons.language, color: color0),
          const SizedBox(width: 5),
          ValueListenableBuilder<String>(
            valueListenable: lenguaje,
            builder: (context, value, child) {
              return Text(
                value.toUpperCase(),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: color0,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 8,
      color: Colors.white,
      itemBuilder: (BuildContext context) {
        return languages.map((String language) {
          return PopupMenuItem<String>(
            value: language,
            child: Row(
              children: [
                ClipRRect(
                  child: Image.asset(
                    'assets/misc/${language.toLowerCase()}.png',
                    width: 24,
                    height: 16,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  language,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: lenguaje.value == language
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color:
                        lenguaje.value == language ? Colors.blue : Colors.black,
                  ),
                ),
                if (lenguaje.value == language)
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20,
                    ),
                  ),
              ],
            ),
          );
        }).toList();
      },
    );
  } //*- Dropdown de idioma -*\\
}
