import 'package:flutter/material.dart';
import 'package:ui_components/circular_selector/theme/circular_selector_theme_data.dart';

class CircularSelectorControl extends StatelessWidget {
  const CircularSelectorControl({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CircularSelectorThemeData.of(context);

    return SizedBox.square(
      dimension: theme.controlDimension,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.controlBackgroundColor,
          shape: BoxShape.circle,
          boxShadow: theme.controlBoxShadow,
          border: theme.controlBorder,
        ),
        child: Center(
          child: SizedBox.square(
            dimension: theme.controlDimension * 0.75,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.controlForegroundColor,
                shape: BoxShape.circle,
                gradient: theme.controlForegroundGradient,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
