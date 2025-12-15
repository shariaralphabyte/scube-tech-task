// ------------------------ SEMI-CIRCULAR WIDGET (ALMOST CIRCLE) ------------------------

import 'dart:math' as math;

import 'package:flutter/material.dart';

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
    this.height = 200,
    this.strokeWidth = 20,
    this.progressColor = AppTheme.circuleColor,
    this.backgroundColor = AppTheme.white,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (value / maxValue).clamp(0.0, 1.0);

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(width, height),
            painter: _AlmostCircularPainter(
              percentage: percentage,
              strokeWidth: strokeWidth,
              progressColor: progressColor,
              backgroundColor: backgroundColor,
            ),
          ),
          Align(
            alignment: const Alignment(0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value.toStringAsFixed(2),
                  style: AppTheme.largeValue.copyWith(fontSize: 18),
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

class _AlmostCircularPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  _AlmostCircularPainter({
    required this.percentage,
    required this.strokeWidth,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final gap = math.pi * 0.3; // 10% gap
    final startAngle = -math.pi /  gap ; // rotate so gap is at bottom
    final sweepAngle = 2 * math.pi - gap;       // almost full circle

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      backgroundPaint,
    );

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle * percentage,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
