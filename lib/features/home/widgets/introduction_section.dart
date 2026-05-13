import 'package:flutter/material.dart';
import 'package:quark_web/core/constants/app_colors.dart';
import 'package:quark_web/core/state/language_notifier.dart';
import 'package:quark_web/core/l10n/app_strings.dart';

class IntroductionSection extends StatefulWidget {
  const IntroductionSection({super.key, required this.onGoToServices});

  final VoidCallback onGoToServices;

  @override
  IntroductionSectionState createState() => IntroductionSectionState();
}

class IntroductionSectionState extends State<IntroductionSection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Controlador para animaciones
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    // Animacion de opacidad
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Animacion de deslizamiento
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 800) {
                  // diferencia las pantallas
                  return _buildSmallScreen(constraints);
                } else {
                  return _buildLargeScreen(constraints);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  //*- Pantallas grandes -*\\
  Widget _buildLargeScreen(BoxConstraints constraints) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 700),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    introductionTitle(lenguaje.value),
                    style: TextStyle(
                      fontSize: constraints.maxWidth > 800 ? 36 : 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    introductionBody(lenguaje.value),
                    style: TextStyle(
                      fontSize: constraints.maxWidth > 800 ? 20 : 16,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 60),
                  Center(
                    child: ElevatedButton(
                      onPressed: widget.onGoToServices,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onSurface,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 10,
                        shadowColor: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.5),
                        textStyle: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: color3,
                        ),
                      ),
                      child: Text(
                        introductionButton(lenguaje.value),
                        style: const TextStyle(
                          color: color3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: AspectRatio(
                  aspectRatio: 1.2,
                  child: Image.asset(
                    'assets/misc/office.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  //*- Pantallas grandes -*\\

  //*- Pantallas pequeñas -*\\
  Widget _buildSmallScreen(BoxConstraints constraints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          introductionTitle(lenguaje.value),
          style: TextStyle(
            fontSize: constraints.maxWidth > 600 ? 36 : 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          introductionBody(lenguaje.value),
          style: TextStyle(
            fontSize: constraints.maxWidth > 600 ? 20 : 16,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        Center(
          child: ElevatedButton(
            onPressed: widget.onGoToServices,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: constraints.maxWidth > 600 ? 20 : 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 10,
              shadowColor: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.5),
              textStyle: TextStyle(
                fontSize: constraints.maxWidth > 600 ? 22 : 18,
                fontWeight: FontWeight.bold,
                color: color3,
              ),
            ),
            child: Text(
              introductionButton(lenguaje.value),
              style: const TextStyle(
                color: color3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: AspectRatio(
            aspectRatio: 1.2,
            child: Image.asset('assets/misc/office.png', fit: BoxFit.contain),
          ),
        ),
      ],
    );
  }

  //*- Pantallas pequeñas -*\\
}
