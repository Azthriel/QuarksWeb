// lib/shared/widgets/error_404_page.dart
// MOVIDO DESDE: lib/widgets/error404.dart  — código sin cambios
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
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleTransition(
                  scale: _headlineScale,
                  child: Text(
                    '404',
                    style: GoogleFonts.orbitron(
                      fontSize: 96,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 8,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Page not found',
                  style: GoogleFonts.orbitron(
                    fontSize: 20,
                    color: Colors.white70,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StarField extends StatefulWidget {
  const _StarField();

  @override
  State<_StarField> createState() => _StarFieldState();
}

class _StarFieldState extends State<_StarField>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  final _rng = Random(42);
  late final List<_Star> _stars;

  @override
  void initState() {
    super.initState();
    _stars = List.generate(
      160,
      (_) => _Star(
        x: _rng.nextDouble(),
        y: _rng.nextDouble(),
        r: _rng.nextDouble() * 1.4 + 0.3,
        phase: _rng.nextDouble() * 2 * pi,
      ),
    );
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => CustomPaint(
        painter: _StarPainter(_stars, _ctrl.value),
      ),
    );
  }
}

class _Star {
  final double x, y, r, phase;
  const _Star({
    required this.x,
    required this.y,
    required this.r,
    required this.phase,
  });
}

class _StarPainter extends CustomPainter {
  final List<_Star> stars;
  final double t;
  _StarPainter(this.stars, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (final s in stars) {
      final opacity =
          (0.4 + 0.6 * (0.5 + 0.5 * sin(2 * pi * t + s.phase))).clamp(0.0, 1.0);
      paint.color = Colors.white.withValues(alpha: opacity);
      canvas.drawCircle(
        Offset(s.x * size.width, s.y * size.height),
        s.r,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_StarPainter old) => old.t != t;
}
