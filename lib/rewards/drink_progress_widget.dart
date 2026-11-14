import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/theme/app_assets.dart';

class DrinkProgressWidget extends StatelessWidget {
  final double width;
  final double height;
  final double progress; // Value between 0.0 and 1.0 (e.g., 0.65 for 65%)

  const DrinkProgressWidget({
    super.key,
    this.width = 100.0,
    this.height = 100.0,
    this.progress = 0.65,
  });

  @override
  Widget build(BuildContext context) {
    // Proportional scaling based on width/height
    final arcWidth = width * 0.9;
    final arcHeight = height * 0.45;
    final cupWidth = width * 0.55;
    final cupHeight = height * 0.75;
    final strokeSize = width * 0.07; // Scalable stroke width

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Semi-circle / Arc Progress Indicator in the background
          Positioned(
            top: height * 0.02,
            child: CustomPaint(
              size: Size(arcWidth, arcHeight),
              painter: _HalfCircleArcPainter(
                progress: progress,
                progressColor: const Color(0xFFFF8A00),
                backgroundColor: const Color(0xFFEFEFEF),
                strokeWidth: strokeSize,
              ),
            ),
          ),
          // Drink Cup Image / Placeholder in the foreground
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: cupWidth,
              height: cupHeight,
              child: Center(
                child: Image.asset(AppAssets.drink),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter to draw the smooth half-circle arc with rounded stroke caps
class _HalfCircleArcPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;

  _HalfCircleArcPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height * 2);
    const startAngle = math.pi; // Start from the left (180 degrees)
    const sweepAngle = math.pi; // Sweep 180 degrees to the right

    // Background track arc
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweepAngle, false, backgroundPaint);

    // Active progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle * progress.clamp(0.0, 1.0),
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _HalfCircleArcPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}