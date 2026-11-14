import 'dart:math' as math;

import 'package:flutter/material.dart';

class DonutProgressIndicator extends StatelessWidget {
  /// The current progress value (e.g., 0.75 or 680000).
  final double progress;

  /// The maximum value representing 100% progress (e.g., 1.0 or 1000000).
  final double totalValue;

  /// Overall diameter of the widget.
  final double size;

  /// Thickness of the donut ring.
  final double strokeWidth;

  /// Animation duration when progress changes.
  final Duration duration;

  /// Animation curve.
  final Curve curve;

  /// Base frosting color.
  final Color frostingColor;

  /// Background track color.
  final Color trackColor;

  /// Optional center widget (e.g., Text showing points).
  final Widget? child;

  const DonutProgressIndicator({
    super.key,
    required this.progress,
    this.totalValue = 1.0,
    this.size = 280.0,
    this.strokeWidth = 54.0,
    this.duration = const Duration(milliseconds: 1200),
    this.curve = Curves.easeOutCubic,
    this.frostingColor = const Color(0xFFF6529A),
    this.trackColor = const Color(0xFFEDF0F3),
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final double targetRatio = totalValue <= 0
        ? 0.0
        : (progress / totalValue).clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: targetRatio),
        duration: duration,
        curve: curve,
        builder: (context, animatedRatio, _) {
          return CustomPaint(
            painter: _DonutProgressPainter(
              progressRatio: animatedRatio,
              strokeWidth: strokeWidth,
              frostingColor: frostingColor,
              trackColor: trackColor,
            ),
            child: Center(
              child: Padding(
                // Keep center content safely inside the inner hole
                padding: EdgeInsets.all(strokeWidth + 12),
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DonutProgressPainter extends CustomPainter {
  final double progressRatio;
  final double strokeWidth;
  final Color frostingColor;
  final Color trackColor;

  _DonutProgressPainter({
    required this.progressRatio,
    required this.strokeWidth,
    required this.frostingColor,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width - strokeWidth) / 2;
    final Rect arcRect = Rect.fromCircle(center: center, radius: radius);

    // 1. Draw the flat light-grey background track
    final Paint trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, trackPaint);

    if (progressRatio <= 0.001) return;

    // Start slightly past 12 o'clock (-pi/2 + 0.12) to match the screenshot's top cap angle
    const double startAngle = -math.pi / 2 + 0.12;
    final double sweepAngle = 2 * math.pi * progressRatio;

    // 2. Create the exact rounded capsule Path for the progress arc
    // Using a Path allows us to clip sprinkles cleanly inside the rounded end-caps
    final Path strokePath = Path()..addArc(arcRect, startAngle, sweepAngle);

    // Paint used to convert stroke into a fillable shape for clipping
    final Paint frostingBasePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = _create3DDonutShader(center, radius);

    // Draw subtle soft drop shadow under the frosting
    final Paint shadowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = frostingColor.withValues(alpha: 0.28)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.save();
    canvas.translate(0, 4);
    canvas.drawPath(strokePath, shadowPaint);
    canvas.restore();

    // Draw main 3D shaded frosting arc
    canvas.drawPath(strokePath, frostingBasePaint);

    // 3. Draw 3D inner-tube specular highlight along the middle of the frosting
    final Paint highlightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 0.42
      ..strokeCap = StrokeCap.round
      ..color = Colors.white.withValues(alpha: 0.22)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, strokeWidth * 0.18);

    canvas.drawPath(strokePath, highlightPaint);

    // 4. Clip to the progress shape and draw the sprinkles texture
    canvas.save();
    // Create an approximate clip region matching the rounded stroke
    _clipToRoundedArc(
      canvas,
      center,
      radius,
      strokeWidth,
      startAngle,
      sweepAngle,
    );
    _drawSprinkles(canvas, center, radius, strokeWidth);
    canvas.restore();
  }

  /// Radial gradient mapped across the ring thickness to create a puffy 3D torus look
  Shader _create3DDonutShader(Offset center, double radius) {
    final double outerEdge = radius + (strokeWidth / 2);
    final double innerStop = ((radius - strokeWidth / 2) / outerEdge).clamp(
      0.0,
      1.0,
    );
    final double midStop = (radius / outerEdge).clamp(0.0, 1.0);

    final Color darkPink = HSLColor.fromColor(
      frostingColor,
    ).withLightness(0.54).toColor();
    final Color lightPink = HSLColor.fromColor(
      frostingColor,
    ).withLightness(0.73).toColor();

    return RadialGradient(
      colors: [
        darkPink, // Inner edge shadow
        lightPink, // Puffy center highlight
        frostingColor,
        darkPink, // Outer edge rim
      ],
      stops: [
        innerStop,
        innerStop + (midStop - innerStop) * 0.85,
        midStop + (1.0 - midStop) * 0.55,
        1.0,
      ],
    ).createShader(Rect.fromCircle(center: center, radius: outerEdge));
  }

  /// Clips the canvas strictly to the rounded capsule arc so sprinkles never spill out
  void _clipToRoundedArc(
    Canvas canvas,
    Offset center,
    double radius,
    double strokeWidth,
    double startAngle,
    double sweepAngle,
  ) {
    final double halfStroke = strokeWidth / 2;
    final double outerR = radius + halfStroke;
    final double innerR = radius - halfStroke;
    final double endAngle = startAngle + sweepAngle;

    final Path clipPath = Path();

    if (sweepAngle >= 2 * math.pi - 0.001) {
      clipPath
        ..addOval(Rect.fromCircle(center: center, radius: outerR))
        ..addOval(Rect.fromCircle(center: center, radius: innerR))
        ..fillType = PathFillType.evenOdd;
    } else {
      // Outer arc
      clipPath.arcTo(
        Rect.fromCircle(center: center, radius: outerR),
        startAngle,
        sweepAngle,
        true,
      );

      // End cap circle
      final Offset endCapCenter = Offset(
        center.dx + radius * math.cos(endAngle),
        center.dy + radius * math.sin(endAngle),
      );
      clipPath.addOval(
        Rect.fromCircle(center: endCapCenter, radius: halfStroke),
      );

      // Inner arc (reverse)
      clipPath.arcTo(
        Rect.fromCircle(center: center, radius: innerR),
        endAngle,
        -sweepAngle,
        false,
      );

      // Start cap circle
      final Offset startCapCenter = Offset(
        center.dx + radius * math.cos(startAngle),
        center.dy + radius * math.sin(startAngle),
      );
      clipPath.addOval(
        Rect.fromCircle(center: startCapCenter, radius: halfStroke),
      );
    }

    canvas.clipPath(clipPath);
  }

  /// Draws deterministic pill-shaped sprinkles across the donut surface
  /// Draws fewer, evenly spread pill-shaped sprinkles across the donut surface
  void _drawSprinkles(
      Canvas canvas,
      Offset center,
      double radius,
      double strokeWidth,
      ) {
    final math.Random random = math.Random(18);
    const int sprinkleCount = 26;
    final double sprinkleLength = strokeWidth * 0.34;
    final double sprinkleThickness = strokeWidth * 0.105;

    final Paint sprinklePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = sprinkleThickness
      ..strokeCap = StrokeCap.round;

    // 3 radial lanes (inner, center, outer) cycled in a non-adjacent order to prevent clumping
    const List<double> radialLanes = [-0.27, 0.25, -0.02, 0.28, -0.24, 0.04];

    for (int i = 0; i < sprinkleCount; i++) {
      // Even angular spacing with minimal jitter so sprinkles stay well separated
      final double baseAngle = (2 * math.pi / sprinkleCount) * i;
      final double angle = baseAngle + (random.nextDouble() - 0.5) * 0.04;

      // Alternate across inner, middle, and outer lanes + slight organic offset
      final double laneFactor = radialLanes[i % radialLanes.length];
      final double jitter = (random.nextDouble() - 0.5) * 0.08;
      final double r = radius + (laneFactor + jitter) * strokeWidth;

      final Offset pos = Offset(
        center.dx + r * math.cos(angle),
        center.dy + r * math.sin(angle),
      );

      final double tilt = random.nextDouble() * math.pi;

      sprinklePaint.color = i % 5 == 0
          ? Colors.white.withValues(alpha: 0.52)
          : Colors.white.withValues(alpha: 0.32);

      canvas.save();
      canvas.translate(pos.dx, pos.dy);
      canvas.rotate(tilt);

      final Path pill = Path()
        ..moveTo(-sprinkleLength / 2, 0)
        ..quadraticBezierTo(
          0,
          (random.nextDouble() - 0.5) * 2.5,
          sprinkleLength / 2,
          0,
        );

      canvas.drawPath(pill, sprinklePaint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _DonutProgressPainter oldDelegate) {
    return oldDelegate.progressRatio != progressRatio ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.frostingColor != frostingColor ||
        oldDelegate.trackColor != trackColor;
  }
}
