import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage>
    with TickerProviderStateMixin {
  late final AnimationController _headlineCtrl;
  late final Animation<double> _headlineScale;
  late final AnimationController _spinCtrl;
  late final AnimationController _driftCtrl;
  late final Animation<Alignment> _driftAlignment;

  @override
  void initState() {
    super.initState();

    _headlineCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _headlineScale = CurvedAnimation(
      parent: _headlineCtrl,
      curve: Curves.elasticOut,
    );
    _headlineCtrl.forward();

    _spinCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    _driftCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    _driftAlignment = AlignmentTween(
      begin: const Alignment(-1.2, -0.4),
      end: const Alignment(1.2, 0.4),
    ).animate(_driftCtrl);
  }

  @override
  void dispose() {
    _headlineCtrl.dispose();
    _spinCtrl.dispose();
    _driftCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Positioned.fill(child: _StarField()),

          // Tripulante animado (sigue girando/derivando)
          AnimatedBuilder(
            animation: _driftAlignment,
            builder: (context, child) => Align(
              alignment: _driftAlignment.value,
              child: RotationTransition(turns: _spinCtrl, child: child),
            ),
            child: SizedBox(
              height: 120,
              child: Image.asset(
                'assets/misc/amongus_crewmate.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Texto 404
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScaleTransition(
                    scale: _headlineScale,
                    child: Text(
                      '404',
                      style: GoogleFonts.roboto(
                        fontSize: MediaQuery.of(context).size.width * 0.2,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFFDA6A00),
                        shadows: const [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            color: Colors.white24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '¡Ups! Parece que esta ruta no existe.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StarField extends StatelessWidget {
  const _StarField();

  static final _StarPainter _painter = _StarPainter();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: _painter,
        size: Size.infinite,
      ),
    );
  }
}

class _StarPainter extends CustomPainter {
  static const int _starCount = 120;
  static const double _maxRadius = 1.8;

  final Random _rng = Random(1);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.8);

    for (int i = 0; i < _starCount; i++) {
      final offset = Offset(
        _rng.nextDouble() * size.width,
        _rng.nextDouble() * size.height,
      );
      canvas.drawCircle(
        offset,
        _rng.nextDouble() * _maxRadius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
