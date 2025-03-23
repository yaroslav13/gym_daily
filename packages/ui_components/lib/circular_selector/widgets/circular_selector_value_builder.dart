import 'package:flutter/material.dart';
import 'package:ui_components/circular_selector/circular_selector_theme_data.dart';

class CircularSelectorValueBuilder<T> extends StatelessWidget {
  const CircularSelectorValueBuilder({
    required this.currentItem,
    this.currentItemWidget,
    super.key,
  });

  final Widget? currentItemWidget;
  final T currentItem;

  @override
  Widget build(BuildContext context) {
    final theme = CircularSelectorThemeData.of(context);

    return Center(
      child: SizedBox.square(
        dimension: theme.valueZoneDimension,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            gradient: theme.centerBackgroundGradient,
            boxShadow: theme.centerBoxShadow,
          ),
          child: Center(
            child: currentItemWidget ??
                Text(
                  currentItem.toString(),
                  style: theme.valueBuilderTextStyle,
                ),
          ),
        ),
      ),
    );
  }
}
