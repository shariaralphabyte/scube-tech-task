import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../core/theme/app_theme.dart';

class CircularProgressWidget extends StatelessWidget {
  final double value;
  final double maxValue;
  final String unit;
  final double size;          // Diameter of the circle
  final double strokeWidth;   // Thickness of the progress arc
  final Color progressColor;
  final Color backgroundColor;

  const CircularProgressWidget({
    super.key,
    required this.value,
    this.maxValue = 100,
    required this.unit,
    this.size = 200,            // Bigger circle by default
    this.strokeWidth = 20,      // Slightly thicker stroke
    this.progressColor = AppTheme.circuleColor,
    this.backgroundColor = AppTheme.white,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (value / maxValue).clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CircularProgressPainter(
          percentage: percentage,
          strokeWidth: strokeWidth,
          progressColor: progressColor,
          backgroundColor: backgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Total Power",
                style: TextStyle(
                  color: AppTheme.textGray,
                  fontSize: size * 0.1,

                ),
              ),
              Text(
                '${value.toStringAsFixed(2)}kw',
                style: AppTheme.largeValue.copyWith(fontSize: 16),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  _CircularProgressPainter({
    required this.percentage,
    required this.strokeWidth,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2; // Start from top
    final sweepAngle = 2 * math.pi * percentage;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
