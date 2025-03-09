import 'package:flutter/material.dart';
import 'package:ui_components/circular_selector/circular_selector_theme_data.dart';
import 'package:ui_components/circular_selector/progress_arc_painter.dart';

class CircularSelectorProgress extends StatelessWidget {
  const CircularSelectorProgress({
    super.key,
    required this.totalValues,
    required this.initialValueIndex,
    required this.currentValueIndex,
  });

  final int totalValues;
  final int initialValueIndex;
  final int currentValueIndex;

  @override
  Widget build(BuildContext context) {
    final theme = CircularSelectorThemeData.of(context);

    return Center(
      child: SizedBox.square(
        dimension: theme.valueZoneDimension,
        child: CustomPaint(
          painter: ProgressArcPainter(
            gradientFactory: theme.progressGradientFactory,
            totalValues: totalValues,
            initialValueIndex: initialValueIndex,
            currentValueIndex: currentValueIndex,
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
