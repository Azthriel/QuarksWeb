import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quark_web/core/constants/app_colors.dart';
import 'package:quark_web/core/state/language_notifier.dart';
import 'package:quark_web/core/state/theme_notifier.dart';

// ---------------------------------------------------------------------------
// Modelo de proyecto
// ---------------------------------------------------------------------------
class PortfolioProject {
  final String categoryES;
  final String categoryEN;
  final Color categoryColor;
  final int number;
  final String nameES;
  final String nameEN;
  final String descriptionES;
  final String descriptionEN;
  final List<String> tags;
  final List<String> images; // 3 imágenes por proyecto

  const PortfolioProject({
    required this.categoryES,
    required this.categoryEN,
    required this.categoryColor,
    required this.number,
    required this.nameES,
    required this.nameEN,
    required this.descriptionES,
    required this.descriptionEN,
    required this.tags,
    required this.images,
  });
}

const List<PortfolioProject> _projects = [
  PortfolioProject(
    categoryES: 'APP WEB',
    categoryEN: 'APP WEB',
    categoryColor: color2,
    number: 1,
    nameES: 'Quiropraxia San Pablo',
    nameEN: 'Quiropraxia San Pablo',
    descriptionES:
        'Aplicación web donde los usuarios pueden acceder para programar sus citas y consultar los informes que se envían mediante el sistema de gestión diseñado para los profesionales, en el cual podrán organizar citas, planes, cargar informes y tener un control completo sobre sus pacientes.',
    descriptionEN:
        'Web application where users can access to schedule their appointments and consult the reports that are sent through the management system designed for professionals, in which they can organize appointments, plans, upload reports and have complete control over their patients.',
    tags: ['Flutter', 'Firebase', 'Checkout Mercado Pago', 'Python'],
    images: [
      'assets/portfolio/quiropraxia_1.png',
      'assets/portfolio/quiropraxia_2.png',
      'assets/portfolio/quiropraxia_3.png',
    ],
  ),
  PortfolioProject(
    categoryES: 'APP WEB',
    categoryEN: 'APP WEB',
    categoryColor: color3,
    number: 2,
    nameES: 'San Pablo Apóstol',
    nameEN: 'San Pablo Apóstol',
    descriptionES:
        'Aplicación web desarrollada para el grupo scout San Pablo Apóstol, orientada a digitalizar y simplificar la gestión de ventas de pastelitos. Los compradores pueden realizar y autogestionar sus pedidos eligiendo cantidades y sabores, abonando de forma rápida y segura a través de Mercado Pago. Los responsables acceden a un panel protegido donde visualizan el listado completo con filtros por rama y vendedor, gestionan el estado de entrega y consultan los totales en tiempo real.',
    descriptionEN:
        'Web application developed for the San Pablo Apóstol scout group, aimed at digitizing and simplifying the management of cupcake sales. Buyers can place and self-manage their orders by choosing quantities and flavors, paying quickly and securely through Mercado Pago.Those responsible access a protected panel where they view the complete list with filters by branch and seller, manage the delivery status and consult the totals in real time.',
    tags: ['Flutter', 'Firebase', 'Checkout Mercado Pago', 'Python'],
    images: [
      'assets/portfolio/sanpablo_1.png',
      'assets/portfolio/sanpablo_2.png',
      'assets/portfolio/sanpablo_3.png',
    ],
  ),
  PortfolioProject(
    categoryES: 'SOFTWARE A MEDIDA',
    categoryEN: 'CUSTOM SOFTWARE',
    categoryColor: color2,
    number: 3,
    nameES: 'Distribuidora Eyhera',
    nameEN: 'Distribuidora Eyhera',
    descriptionES:
        'Aplicación web desarrollada para Distribuidora Eyhera, orientada a digitalizar y optimizar la operación diaria de una distribuidora. Cuenta con un catálogo inteligente donde los productos pueden cargarse mediante PDFs analizados con IA, que extrae y registra los ítems automáticamente. Incluye un planeador de rutas integrado con la API de Google Places que sugiere puntos de visita dentro de un radio configurable, un generador de planillas de carga para organizar cada salida de la camioneta, y un gestor completo de clientes para mantener el control de toda la cartera comercial.',
    descriptionEN:
        'Web application developed for Distribuidora Eyhera, aimed at digitizing and optimizing the daily operation of a distributor. It has an intelligent catalog where products can be loaded using PDFs analyzed with AI, which extracts and records the items automatically. It includes a route planner integrated with the Google Places API that suggests visiting points within a configurable radius, a load sheet generator to organize each van departure, and a complete customer manager to maintain control of the entire commercial portfolio.',
    tags: ['Flutter', 'Firebase', 'Python', 'Integración con IA', 'API de Google Maps'],
    images: [
      'assets/portfolio/eyhera_1.png',
      'assets/portfolio/eyhera_2.png',
      'assets/portfolio/eyhera_3.png',
    ],
  ),
];

// ---------------------------------------------------------------------------
// Widget principal
// Escucha temaApp (ValueNotifier<ThemeMode>) y usa el getter isDarkMode
// ---------------------------------------------------------------------------
class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: temaApp,
      builder: (context, _, __) {
        final dark = isDarkMode;
        final textPrimary = Theme.of(context).colorScheme.onSurface;

        return ValueListenableBuilder<String>(
          valueListenable: lenguaje,
          builder: (context, lang, _) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
              color: Theme.of(context).colorScheme.surface,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionHeader(lang: lang, textPrimary: textPrimary),
                      const SizedBox(height: 80),
                      ..._projects.asMap().entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 80),
                          child: _ProjectItem(
                            project: entry.value,
                            imageOnLeft: entry.key % 2 == 0,
                            lang: lang,
                            dark: dark,
                            textPrimary: textPrimary,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Header de sección
// ---------------------------------------------------------------------------
class _SectionHeader extends StatelessWidget {
  final String lang;
  final Color textPrimary;

  const _SectionHeader({required this.lang, required this.textPrimary});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;
        final title =
            lang == 'EN'
                ? 'Products we\'ve built\nthat matter.'
                : 'Productos que\nconstruimos.';
        final subtitle =
            lang == 'EN'
                ? 'Real projects generating value\nfor real businesses.'
                : 'Proyectos reales generando valor\npara negocios reales.';
        final tag = lang == 'EN' ? 'SELECTED WORK' : 'TRABAJO SELECCIONADO';

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TagLabel(text: tag),
              const SizedBox(height: 12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: textPrimary,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: textPrimary.withValues(alpha: 0.55),
                  height: 1.5,
                ),
              ),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TagLabel(text: tag),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                      color: textPrimary,
                      height: 1.05,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 60),
            SizedBox(
              width: 280,
              child: Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: textPrimary.withValues(alpha: 0.55),
                  height: 1.6,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TagLabel extends StatelessWidget {
  final String text;
  const _TagLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: color3,
        letterSpacing: 2.5,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Item de proyecto
// ---------------------------------------------------------------------------
class _ProjectItem extends StatelessWidget {
  final PortfolioProject project;
  final bool imageOnLeft;
  final String lang;
  final bool dark;
  final Color textPrimary;

  const _ProjectItem({
    required this.project,
    required this.imageOnLeft,
    required this.lang,
    required this.dark,
    required this.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) return _buildMobile();
        return _buildDesktop();
      },
    );
  }

  Widget _buildDesktop() {
    final carousel = _ProjectCarousel(project: project, dark: dark);
    final info = _ProjectInfo(
      project: project,
      lang: lang,
      textPrimary: textPrimary,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:
          imageOnLeft
              ? [
                Expanded(flex: 5, child: carousel),
                const SizedBox(width: 60),
                Expanded(flex: 4, child: info),
              ]
              : [
                Expanded(flex: 4, child: info),
                const SizedBox(width: 60),
                Expanded(flex: 5, child: carousel),
              ],
    );
  }

  Widget _buildMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProjectCarousel(project: project, dark: dark),
        const SizedBox(height: 28),
        _ProjectInfo(project: project, lang: lang, textPrimary: textPrimary),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Carousel — BoxFit.contain para que la imagen no desborde el box
// ---------------------------------------------------------------------------
class _ProjectCarousel extends StatefulWidget {
  final PortfolioProject project;
  final bool dark;
  const _ProjectCarousel({required this.project, required this.dark});

  @override
  State<_ProjectCarousel> createState() => _ProjectCarouselState();
}

class _ProjectCarouselState extends State<_ProjectCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final accent = widget.project.categoryColor;
    final cardBg =
        widget.dark ? const Color(0xFF1C1C1C) : accent.withValues(alpha: 0.06);

    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final boxH = constraints.maxWidth > 500 ? 320.0 : 220.0;

            return Container(
              height: boxH,
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: accent.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: boxH,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(milliseconds: 600),
                  viewportFraction: 1.0,
                  onPageChanged: (i, _) => setState(() => _currentIndex = i),
                ),
                items:
                    widget.project.images.map((path) {
                      return SizedBox(
                        width: double.infinity,
                        height: boxH,
                        child: Image.asset(
                          path,
                          fit: BoxFit.contain,
                          errorBuilder:
                              (_, __, ___) => Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_search_outlined,
                                      size: 52,
                                      color: accent.withValues(alpha: 0.3),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'asset pendiente',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: accent.withValues(alpha: 0.4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        ),
                      );
                    }).toList(),
              ),
            );
          },
        ),
        const SizedBox(height: 14),
        // Dots indicadores
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.project.images.length, (i) {
            final active = _currentIndex == i;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: active ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: active ? accent : accent.withValues(alpha: 0.25),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Info del proyecto
// ---------------------------------------------------------------------------
class _ProjectInfo extends StatelessWidget {
  final PortfolioProject project;
  final String lang;
  final Color textPrimary;

  const _ProjectInfo({
    required this.project,
    required this.lang,
    required this.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    final category = lang == 'EN' ? project.categoryEN : project.categoryES;
    final name = lang == 'EN' ? project.nameEN : project.nameES;
    final desc = lang == 'EN' ? project.descriptionEN : project.descriptionES;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _CategoryBadge(label: category, color: project.categoryColor),
            const SizedBox(width: 14),
            Text(
              '/ ${project.number.toString().padLeft(2, '0')}',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: textPrimary.withValues(alpha: 0.35),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: textPrimary,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          desc,
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: textPrimary.withValues(alpha: 0.65),
            height: 1.7,
          ),
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              project.tags
                  .map((t) => _TechTag(label: t, textPrimary: textPrimary))
                  .toList(),
        ),
      ],
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _CategoryBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 1.8,
        ),
      ),
    );
  }
}

class _TechTag extends StatelessWidget {
  final String label;
  final Color textPrimary;
  const _TechTag({required this.label, required this.textPrimary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: textPrimary.withValues(alpha: 0.05),
        border: Border.all(color: textPrimary.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 13,
          color: textPrimary.withValues(alpha: 0.75),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
