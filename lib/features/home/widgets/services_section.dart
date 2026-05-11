import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:quark_web/core/state/language_notifier.dart';
import 'package:quark_web/core/l10n/app_strings.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  ServicesSectionState createState() => ServicesSectionState();
}

class ServicesSectionState extends State<ServicesSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController1;
  late AnimationController _animationController2;
  late AnimationController _animationController3;
  late Animation<Offset> _offsetAnimation1;
  late Animation<Offset> _offsetAnimation2;
  late Animation<Offset> _offsetAnimation3;
  late Animation<double> _opacityAnimation1;
  late Animation<double> _opacityAnimation2;
  late Animation<double> _opacityAnimation3;

  @override
  void initState() {
    super.initState();

    _animationController1 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animationController2 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animationController3 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation1 = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController1, curve: Curves.easeInOut),
    );
    _opacityAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController1, curve: Curves.easeInOut),
    );

    _offsetAnimation2 = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController2, curve: Curves.easeInOut),
    );
    _opacityAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController2, curve: Curves.easeInOut),
    );

    _offsetAnimation3 = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController3, curve: Curves.easeInOut),
    );
    _opacityAnimation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController3, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController1.dispose();
    _animationController2.dispose();
    _animationController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                serviceTitle(lenguaje.value),
                style: GoogleFonts.roboto(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                serviceDescription(lenguaje.value),
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 100),
              VisibilityDetector(
                key: const Key('service-1'),
                onVisibilityChanged: (info) {
                  if (info.visibleFraction > 0.5) {
                    _animationController1.forward();
                  }
                },
                child: _buildService(
                  imagePath: 'assets/services/mobile_app.png',
                  title: appMobileTitle(lenguaje.value),
                  description: appMobileDescription(lenguaje.value),
                  isImageLeft: true,
                  offsetAnimation: _offsetAnimation1,
                  opacityAnimation: _opacityAnimation1,
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.onSurface,
                thickness: 1,
                height: 40,
              ),
              VisibilityDetector(
                key: const Key('service-2'),
                onVisibilityChanged: (info) {
                  if (info.visibleFraction > 0.5) {
                    _animationController2.forward();
                  }
                },
                child: _buildService(
                  imagePath: 'assets/services/web_development.png',
                  title: webDevelopmentTitle(lenguaje.value),
                  description: webDevelopmentDescription(lenguaje.value),
                  isImageLeft: false,
                  offsetAnimation: _offsetAnimation2,
                  opacityAnimation: _opacityAnimation2,
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.onSurface,
                thickness: 1,
                height: 40,
              ),
              VisibilityDetector(
                key: const Key('service-3'),
                onVisibilityChanged: (info) {
                  if (info.visibleFraction > 0.5) {
                    _animationController3.forward();
                  }
                },
                child: _buildService(
                  imagePath: 'assets/services/software_development.png',
                  title: customSoftwareTitle(lenguaje.value),
                  description: customSoftwareDescription(lenguaje.value),
                  isImageLeft: true,
                  offsetAnimation: _offsetAnimation3,
                  opacityAnimation: _opacityAnimation3,
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.onSurface,
                thickness: 1,
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //*- Método que construye cada servicio -*\\
  Widget _buildService({
    required String imagePath,
    required String title,
    required String description,
    required bool isImageLeft,
    required Animation<Offset> offsetAnimation,
    required Animation<double> opacityAnimation,
  }) {
    return FadeTransition(
      opacity: opacityAnimation,
      child: SlideTransition(
        position: offsetAnimation,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isImageLeft) ...[
              _buildImage(imagePath),
              const SizedBox(width: 40),
              _buildTextSection(title, description),
            ] else ...[
              _buildTextSection(title, description),
              const SizedBox(width: 40),
              _buildImage(imagePath),
            ],
          ],
        ),
      ),
    );
  }
  //*- Método que construye cada servicio -*\\

  //*- Widget para la imagen -*\\
  Widget _buildImage(String imagePath) {
    return Expanded(
      flex: 1,
      child: Image.asset(imagePath, fit: BoxFit.contain, height: 350),
    );
  }
  //*- Widget para la imagen -*\\

  //*- Widget para la sección de texto -*\\
  Widget _buildTextSection(String title, String description) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  //*- Widget para la sección de texto -*\\
}
