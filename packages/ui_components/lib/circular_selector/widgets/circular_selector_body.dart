import 'package:flutter/material.dart';
import 'package:ui_components/circular_selector/theme/circular_selector_theme_data.dart';
import 'package:ui_components/circular_selector/widgets/circular_selector_control.dart';
import 'package:ui_components/circular_selector/widgets/circular_selector_progress.dart';
import 'package:ui_components/circular_selector/widgets/circular_selector_value_builder.dart';

class CircularSelectorBody<T> extends StatelessWidget {
  const CircularSelectorBody({
    required this.onPanUpdate,
    required this.onPanStart,
    required this.onPanEnd,
    required this.controlPosition,
    required this.currentItemWidget,
    required this.currentItem,
    required this.initialItemIndex,
    required this.totalItemsCount,
    required this.currentItemIndex,
    super.key,
  });

  final void Function(
    DragUpdateDetails, {
    required double widgetDimension,
    required double slideZoneDimension,
    required double controlDimension,
  }) onPanUpdate;
  final ValueChanged<DragStartDetails> onPanStart;
  final ValueChanged<DragEndDetails> onPanEnd;
  final Offset controlPosition;
  final Widget? currentItemWidget;
  final T currentItem;
  final int initialItemIndex;
  final int totalItemsCount;
  final int currentItemIndex;

  @override
  Widget build(BuildContext context) {
    final theme = CircularSelectorThemeData.of(context);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: LimitedBox(
        child: SizedBox.square(
          dimension: theme.dimension,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(theme.dimension / 2),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: theme.slideSurfaceGradient,
                boxShadow: theme.slideSurfaceBoxShadow,
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: controlPosition.dy,
                    left: controlPosition.dx,
                    child: const CircularSelectorControl(),
                  ),
                  CircularSelectorValueBuilder(
                    currentItemWidget: currentItemWidget,
                    currentItem: currentItem,
                  ),
                  CircularSelectorProgress(
                    totalValues: totalItemsCount,
                    initialValueIndex: initialItemIndex,
                    currentValueIndex: currentItemIndex,
                  ),
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanStart: onPanStart,
                      onPanUpdate: (details) => onPanUpdate(
                        details,
                        widgetDimension: theme.dimension,
                        slideZoneDimension: theme.slideZoneDimension,
                        controlDimension: theme.controlDimension,
                      ),
                      onPanEnd: onPanEnd,
                      child: const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
