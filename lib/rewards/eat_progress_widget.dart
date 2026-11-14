import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/theme/app_assets.dart';

class EatProgressWidget extends StatelessWidget {
  final double width;
  final double height;
  final double progress; // Value between 0.0 (0%) and 1.0 (100%)

  const EatProgressWidget({
    super.key,
    this.width = 100.0,
    this.height = 100.0,
    this.progress = 0.25,
  });

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    final bool showFullColor = clampedProgress <= 0.0 || clampedProgress >= 1.0;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Background Layer: Full Grayscale Donut
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: const ColorFilter.matrix(<double>[
                0.2126, 0.7152, 0.0722, 0, 0,
                0.2126, 0.7152, 0.0722, 0, 0,
                0.2126, 0.7152, 0.0722, 0, 0,
                0,      0,      0,      1, 0,
              ]),
              child: Image.asset(
                AppAssets.donut,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 2. Foreground Layer: Colorful Donut Wedge (or Full Color if 0.0 / 1.0)
          Positioned.fill(
            child: showFullColor
                ? Image.asset(
              AppAssets.donut,
              fit: BoxFit.contain,
            )
                : ClipPath(
              clipper: _DonutWedgeClipper(progress: clampedProgress),
              child: Image.asset(
                AppAssets.donut,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom Clipper that creates a clockwise progress wedge starting from 12 o'clock
class _DonutWedgeClipper extends CustomClipper<Path> {
  final double progress;

  const _DonutWedgeClipper({required this.progress});

  @override
  Path getClip(Size size) {
    final path = Path();
    if (progress <= 0.0) return path;

    final center = Offset(size.width / 2, size.height / 2);
    // Use max dimension to ensure the radius fully covers the widget bounds
    final radius = math.max(size.width, size.height) * 1.5;

    const startAngle = -math.pi / 2; // 12 o'clock position (-90 degrees)
    final sweepAngle = 2 * math.pi * progress;

    path.moveTo(center.dx, center.dy);
    path.arcTo(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false, // Clockwise
    );
    path.lineTo(center.dx, center.dy);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant _DonutWedgeClipper oldClipper) {
    return oldClipper.progress != progress;
  }
}