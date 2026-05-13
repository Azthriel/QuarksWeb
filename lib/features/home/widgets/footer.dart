import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quark_web/core/constants/app_colors.dart';
import 'package:quark_web/core/state/language_notifier.dart';
import 'package:quark_web/core/state/theme_notifier.dart';
import 'package:url_launcher/url_launcher.dart';

// ---------------------------------------------------------------------------
// Footer rediseñado — escucha temaApp y lenguaje
// ---------------------------------------------------------------------------
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: temaApp,
      builder: (context, _, __) {
        final footerBg =
            isDarkMode ? const Color(0xFF080808) : const Color(0xFF111111);
        final textMuted = Colors.white.withValues(alpha: 0.4);
        final dividerColor = Colors.white.withValues(alpha: 0.08);

        return ValueListenableBuilder<String>(
          valueListenable: lenguaje,
          builder: (context, lang, _) {
            return Container(
              color: footerBg,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 56,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: LayoutBuilder(
                          builder: (ctx, constraints) {
                            if (constraints.maxWidth < 700) {
                              return _buildMobile(
                                lang,
                                textMuted,
                                dividerColor,
                              );
                            }
                            return _buildDesktop(lang, textMuted, dividerColor);
                          },
                        ),
                      ),
                    ),
                  ),
                  Divider(color: dividerColor, height: 1, thickness: 1),
                  _CopyrightBar(lang: lang, textMuted: textMuted),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDesktop(String lang, Color textMuted, Color dividerColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: _BrandColumn(lang: lang, textMuted: textMuted),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 4,
          child: _ContactColumn(lang: lang, textMuted: textMuted),
        ),
      ],
    );
  }

  Widget _buildMobile(String lang, Color textMuted, Color dividerColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BrandColumn(lang: lang, textMuted: textMuted),
        const SizedBox(height: 40),
        Divider(color: dividerColor, height: 1),
        const SizedBox(height: 40),
        _ContactColumn(lang: lang, textMuted: textMuted),
      ],
    );
  }
}

class _CopyrightBar extends StatelessWidget {
  final String lang;
  final Color textMuted;
  const _CopyrightBar({required this.lang, required this.textMuted});

  @override
  Widget build(BuildContext context) {
    final copyright =
        lang == 'EN'
            ? '™ 2024 / 2026 Quarks Studio — All rights reserved'
            : '™ 2024 / 2026 Quarks Studio — Todos los derechos reservados';
    final madeWith =
        lang == 'EN' ? 'Made with Flutter 💙' : 'Hecho con Flutter 💙';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              if (constraints.maxWidth < 600) {
                return Column(
                  children: [
                    Text(
                      copyright,
                      style: GoogleFonts.poppins(fontSize: 12, color: textMuted),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      madeWith,
                      style: GoogleFonts.poppins(fontSize: 12, color: textMuted),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    copyright,
                    style: GoogleFonts.poppins(fontSize: 12, color: textMuted),
                  ),
                  Text(
                    madeWith,
                    style: GoogleFonts.poppins(fontSize: 12, color: textMuted),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Col 1 — Marca + tagline + redes
// ---------------------------------------------------------------------------
class _BrandColumn extends StatelessWidget {
  final String lang;
  final Color textMuted;

  const _BrandColumn({required this.lang, required this.textMuted});

  @override
  Widget build(BuildContext context) {
    final tagline =
        lang == 'EN'
            ? 'We build Flutter apps that solve real problems for real businesses.'
            : 'Construimos apps Flutter que resuelven problemas reales para negocios reales.';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/isologo.png',
          height: 36,
          color: Colors.white,
          colorBlendMode: BlendMode.srcIn,
          errorBuilder:
              (_, __, ___) => Text(
                'QUARKS STUDIO',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: color3,
                  letterSpacing: 1,
                ),
              ),
        ),
        const SizedBox(height: 16),
        Text(
          tagline,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: textMuted,
            height: 1.65,
          ),
        ),
        const SizedBox(height: 28),
        // Botones de redes sociales
        const Row(
          children: [
            _SocialBtn(
              tooltip: 'Instagram',
              icon: FontAwesomeIcons.instagram,
              link: 'https://www.instagram.com/quarksstudioapps/',
            ),
            SizedBox(width: 12),
            _SocialBtn(
              tooltip: 'LinkedIn',
              icon: FontAwesomeIcons.linkedin,
              link: 'https://www.linkedin.com/company/quarksstudio',
            ),
            SizedBox(width: 12),
            _SocialBtn(
              tooltip: 'GitHub',
              icon: FontAwesomeIcons.github,
              link: 'https://github.com/quarks-studio',
            ),
            SizedBox(width: 12),
            _SocialBtn(
              tooltip: 'WhatsApp',
              icon: FontAwesomeIcons.whatsapp,
              link: 'https://wa.me/5491158557593',
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialBtn extends StatefulWidget {
  final String tooltip;
  final FaIconData icon;
  final String link;
  const _SocialBtn({
    required this.tooltip,
    required this.icon,
    required this.link,
  });

  @override
  State<_SocialBtn> createState() => _SocialBtnState();
}

class _SocialBtnState extends State<_SocialBtn> {
  bool _hovered = false;

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Tooltip(
        message: widget.tooltip,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _hovered
                    ? color3.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.07),
            border: Border.all(
              color:
                  _hovered
                      ? color3.withValues(alpha: 0.5)
                      : Colors.white.withValues(alpha: 0.12),
            ),
          ),
          child: Center(
            child: IconButton(
              onPressed: () => _launchURL(widget.link),
              icon: FaIcon(
                widget.icon,
                size: 18,
                color: _hovered ? color3 : Colors.white.withValues(alpha: 0.55),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Col 2 — Contacto
// ---------------------------------------------------------------------------
class _ContactColumn extends StatelessWidget {
  final String lang;
  final Color textMuted;

  const _ContactColumn({required this.lang, required this.textMuted});

  @override
  Widget build(BuildContext context) {
    final title = lang == 'EN' ? 'Contact' : 'Contacto';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: title, textMuted: textMuted),
        const SizedBox(height: 20),
        _FooterInfoItem(
          icon: FontAwesomeIcons.envelope,
          value: 'consultas@quarks-studio.com',
          textMuted: textMuted,
        ),
        const SizedBox(height: 14),
        _FooterInfoItem(
          icon: FontAwesomeIcons.phone,
          value: '+54 9 11 5855-7593',
          textMuted: textMuted,
        ),
        const SizedBox(height: 14),
        _FooterInfoItem(
          icon: FontAwesomeIcons.locationDot,
          value: 'Argentina / Buenos Aires',
          textMuted: textMuted,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
class _SectionTitle extends StatelessWidget {
  final String title;
  final Color textMuted;
  const _SectionTitle({required this.title, required this.textMuted});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: GoogleFonts.poppins(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: textMuted,
        letterSpacing: 2,
      ),
    );
  }
}

class _FooterInfoItem extends StatelessWidget {
  final FaIconData icon;
  final String value;
  final Color textMuted;
  const _FooterInfoItem({
    required this.icon,
    required this.value,
    required this.textMuted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(icon, size: 16, color: textMuted),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.6),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
