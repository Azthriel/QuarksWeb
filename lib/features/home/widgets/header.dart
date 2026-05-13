import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quark_web/core/constants/app_colors.dart';
import 'package:quark_web/core/state/language_notifier.dart';
import 'package:quark_web/core/state/theme_notifier.dart';
import 'package:quark_web/core/utils/scroll_utils.dart';
import 'package:quark_web/core/l10n/app_strings.dart';

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
    final bg = Theme.of(context).colorScheme.surface;
    return PreferredSize(
      preferredSize: widget.preferredSize,
      child: Container(
        color: bg,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              return _buildLargeScreen(context);
            } else {
              return _buildSmallScreen(context);
            }
          },
        ),
      ),
    );
  }

  // ─── Switch de tema ───────────────────────────────────────────────────────
  Widget _buildThemeSwitch() {
    final fg = Theme.of(context).colorScheme.onSurface;
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: temaApp,
      builder: (_, mode, __) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(FontAwesomeIcons.sun, size: 18, color: fg),
            Switch(
              value: mode == ThemeMode.dark,
              onChanged: (_) => toggleTheme(),
              activeThumbColor: color3,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            FaIcon(FontAwesomeIcons.moon, size: 18, color: fg),
          ],
        );
      },
    );
  }

  //*- Pantallas grandes -*\\
  Widget _buildLargeScreen(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/isologo.png', height: 40),
            Row(
              children: [
                buildHeaderButton(
                  nosotros(lenguaje.value),
                  widget.keyIntroduction,
                  context,
                ),
                buildHeaderButton(
                  servicios(lenguaje.value),
                  widget.keyServices,
                  context,
                ),
                buildHeaderButton(
                  herramientas(lenguaje.value),
                  widget.keyTools,
                  context,
                ),
                buildHeaderButton(
                  clientes(lenguaje.value),
                  widget.keyPortfolio,
                  context,
                ),
                buildHeaderButton(
                  contacto(lenguaje.value),
                  widget.keyContact,
                  context,
                ),
              ],
            ),
            Row(
              children: [
                _buildThemeSwitch(),
                const SizedBox(width: 8),
                buildLanguageMenu(),
              ],
            ),
          ],
        ),
      ),
    );
  }
  //*- Pantallas grandes -*\\

  //*- Pantallas pequeñas -*\\
  Widget _buildSmallScreen(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/isologo.png', height: 36),
        Row(
          children: [
            _buildThemeSwitch(),
            buildLanguageMenu(),
            IconButton(
              icon: Icon(Icons.menu, color: fg),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ],
        ),
      ],
    );
  }
  //*- Pantallas pequeñas -*\\

  Widget buildLanguageMenu() {
    final fg = Theme.of(context).colorScheme.onSurface;
    final bg = Theme.of(context).colorScheme.surface;
    return PopupMenuButton<String>(
      onSelected: (String language) {
        if (lenguaje.value != language) {
          changeLanguage(language);
          widget.onChangeLanguage(language);
        }
      },
      icon: Row(
        children: [
          FaIcon(FontAwesomeIcons.language, color: fg),
          const SizedBox(width: 5),
          ValueListenableBuilder<String>(
            valueListenable: lenguaje,
            builder: (context, value, child) {
              return Text(
                value.toUpperCase(),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: fg,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 8,
      color: bg,
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
                    fontWeight:
                        lenguaje.value == language
                            ? FontWeight.bold
                            : FontWeight.normal,
                    color: lenguaje.value == language ? Colors.blue : fg,
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
  }
}
