import 'dart:math';

import 'package:flutter/material.dart';

class ProgressArcPainter extends CustomPainter {
  ProgressArcPainter({
    required this.totalValues,
    required this.initialValueIndex,
    required this.currentValueIndex,
    required this.strokeWidth,
    this.gradientFactory,
  });

  final int totalValues;
  final int initialValueIndex;
  final int currentValueIndex;
  final double strokeWidth;
  final Gradient Function(double, double)? gradientFactory;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (min(size.width, size.height) / 2 - strokeWidth / 2) * 0.75;

    final singleValueAngle = 2 * pi / totalValues;
    final radiusCompensationAngle = 2 * asin((strokeWidth / 2) / (2 * radius));

    // Calculate zero point angle based on initial item index
    final zeroPositionAngle = -pi / 2 -
        initialValueIndex * singleValueAngle +
        radiusCompensationAngle;

    final currentItemAngle = currentValueIndex * singleValueAngle;

    final sweepAngle = currentItemAngle - radiusCompensationAngle;
    // Progress paint with gradient
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = gradientFactory
          ?.call(
            zeroPositionAngle - radiusCompensationAngle,
            sweepAngle - zeroPositionAngle >= pi / 4
                ? sweepAngle + radiusCompensationAngle
                : -pi / 2,
          )
          .createShader(
            Rect.fromCircle(
              center: center,
              radius: radius,
            ),
          );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      zeroPositionAngle,
      sweepAngle - radiusCompensationAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(ProgressArcPainter oldDelegate) {
    return oldDelegate.totalValues != totalValues ||
        oldDelegate.initialValueIndex != initialValueIndex ||
        oldDelegate.currentValueIndex != currentValueIndex ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gradientFactory != gradientFactory;
  }
}
