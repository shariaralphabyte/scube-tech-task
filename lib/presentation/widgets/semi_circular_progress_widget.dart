import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../core/theme/app_theme.dart';

class SemiCircularProgressWidget extends StatelessWidget {
  final double value;
  final double maxValue;
  final String unit;
  final double width;
  final double height;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  const SemiCircularProgressWidget({
    super.key,
    required this.value,
    this.maxValue = 100,
    required this.unit,
    this.width = 200,
    this.height = 100,
    this.strokeWidth = 20,
    this.progressColor = AppTheme.circuleColor,
    this.backgroundColor = AppTheme.white,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (value / maxValue).clamp(0.0, 1.0); // FIXED

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(width, height),
            painter: _SemiCircularProgressPainter(
              percentage: percentage,
              strokeWidth: strokeWidth,
              progressColor: progressColor,
              backgroundColor: backgroundColor,
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.3), // Move text slightly up
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20,),
                Text(
                  value.toStringAsFixed(2),
                  style: AppTheme.largeValue.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 2),
                Text(
                  unit,
                  style: AppTheme.largeValue.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SemiCircularProgressPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  _SemiCircularProgressPainter({
    required this.percentage,
    required this.strokeWidth,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = (size.width - strokeWidth) / 2;

    // Draw background arc (semi-circle)
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,          // Start from left
      math.pi,          // Sweep 180 degrees
      false,
      backgroundPaint,
    );

    // Draw progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = math.pi * percentage; // Half circle progress

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,          // Start from left
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
