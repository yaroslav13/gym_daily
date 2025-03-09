import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_components/circular_selector/circular_selector_theme_data.dart';
import 'package:ui_components/circular_selector/widgets/circular_selector_body.dart';

class CircularValueSelector<T> extends StatefulWidget {
  const CircularValueSelector({
    required this.onChanged,
    required this.items,
    this.currentItemBuilder,
    this.initialItemIndex,
    super.key,
  });

  final ValueChanged<T> onChanged;
  final List<T> items;
  final int? initialItemIndex;
  final Widget Function(
    T item,
    BuildContext context,
  )? currentItemBuilder;

  @override
  State<StatefulWidget> createState() {
    return _CircularValueSelectorState<T>();
  }
}

class _CircularValueSelectorState<T> extends State<CircularValueSelector<T>>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  double _angle = -pi / 2;
  int _lastHapticIndex = 0;

  late Offset _controlPosition;
  late Offset _startDragPosition;
  late double _startDragAngle;
  late AnimationController _animationController;
  late Animation<double> _snapAnimation;

  @override
  void didUpdateWidget(covariant CircularValueSelector<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items ||
        oldWidget.initialItemIndex != widget.initialItemIndex) {
      _init();
      _updateCurrentIndex(useHaptic: false);
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animationController.addListener(() {
      setState(() {
        _angle = _snapAnimation.value;
        _updateControlPosition();
      });
    });
  }

  void _init() {
    _currentIndex = widget.initialItemIndex ?? 0;

    _angle = -pi / 2;
    _lastHapticIndex = _currentIndex;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateControlPosition();
  }

  void _updateControlPosition() {
    final theme = CircularSelectorThemeData.of(context);

    _updateControlPositionWithDimensions(
      widgetDimension: theme.dimension,
      slideZoneDimension: theme.slideZoneDimension,
      controlDimension: theme.controlDimension,
    );
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    _animationController.dispose();
  }

  void _updateControlPositionWithDimensions({
    required double widgetDimension,
    required double slideZoneDimension,
    required double controlDimension,
  }) {
    final controlPathRadius =
        (widgetDimension / 2 + (widgetDimension - slideZoneDimension) / 2) / 2;
    final centerX = widgetDimension / 2;
    final centerY = widgetDimension / 2;

    final controlCenterX = centerX + controlPathRadius * cos(_angle);
    final controlCenterY = centerY + controlPathRadius * sin(_angle);

    _controlPosition = Offset(
      controlCenterX - controlDimension / 2,
      controlCenterY - controlDimension / 2,
    );
  }

  void _onPanStart(DragStartDetails details) {
    _animationController.stop();

    _startDragPosition = details.localPosition;
    _startDragAngle = _angle;
  }

  void _onPanUpdate(
    DragUpdateDetails details, {
    required double widgetDimension,
    required double slideZoneDimension,
    required double controlDimension,
  }) {
    final centerX = widgetDimension / 2;
    final centerY = widgetDimension / 2;

    final startDx = _startDragPosition.dx - centerX;
    final startDy = _startDragPosition.dy - centerY;
    final startAngle = atan2(startDy, startDx);

    final currentDx = details.localPosition.dx - centerX;
    final currentDy = details.localPosition.dy - centerY;
    final currentAngle = atan2(currentDy, currentDx);

    final deltaAngle = currentAngle - startAngle;
    final newAngle = _startDragAngle + deltaAngle;

    setState(() {
      _angle = newAngle;
      _updateControlPositionWithDimensions(
        widgetDimension: widgetDimension,
        slideZoneDimension: slideZoneDimension,
        controlDimension: controlDimension,
      );
      _updateCurrentIndex(animate: false);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    var normalizedAngle = _angle;
    if (normalizedAngle < -pi / 2) normalizedAngle += 2 * pi;
    normalizedAngle = (normalizedAngle + pi / 2) % (2 * pi);

    final segmentSize = 2 * pi / widget.items.length;

    final rawIndex = (normalizedAngle / segmentSize).round();

    final initialIndex = widget.initialItemIndex ?? 0;
    final nearestIndex = (initialIndex + rawIndex) % widget.items.length;

    var targetAngle = -pi / 2 + rawIndex * segmentSize;

    var angleDiff = targetAngle - _angle;

    if (angleDiff > pi) {
      angleDiff -= 2 * pi;
    } else if (angleDiff < -pi) {
      angleDiff += 2 * pi;
    }

    targetAngle = _angle + angleDiff;

    if (nearestIndex != _currentIndex) {
      setState(() {
        _currentIndex = nearestIndex;
      });
      widget.onChanged.call(widget.items[_currentIndex]);
    }

    _snapAnimation = Tween<double>(
      begin: _angle,
      end: targetAngle,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _animationController
      ..reset()
      ..forward();
  }

  void _updateCurrentIndex({
    bool animate = true,
    bool useHaptic = true,
  }) {
    var normalizedAngle = _angle;
    if (normalizedAngle < -pi / 2) normalizedAngle += 2 * pi;
    normalizedAngle = (normalizedAngle + pi / 2) % (2 * pi);

    final segmentSize = 2 * pi / widget.items.length;
    final rawIndex = (normalizedAngle / segmentSize).floor();

    final initialIndex = widget.initialItemIndex ?? 0;
    final index = (initialIndex + rawIndex) % widget.items.length;

    if (index != _lastHapticIndex && useHaptic) {
      HapticFeedback.lightImpact();
      _lastHapticIndex = index;
    }

    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });

      widget.onChanged.call(widget.items[_currentIndex]);

      if (animate) {
        final targetAngle = -pi / 2 + rawIndex * segmentSize;

        _snapAnimation = Tween<double>(
          begin: _angle,
          end: targetAngle,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOutBack,
        ));

        _animationController
          ..reset()
          ..forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircularSelectorBody(
      onPanUpdate: _onPanUpdate,
      onPanStart: _onPanStart,
      onPanEnd: _onPanEnd,
      controlPosition: _controlPosition,
      currentItemWidget: widget.currentItemBuilder?.call(
        widget.items[_currentIndex],
        context,
      ),
      currentItem: widget.items[_currentIndex],
      initialItemIndex: widget.initialItemIndex ?? 0,
      totalItemsCount: widget.items.length,
      currentItemIndex: _currentIndex,
    );
  }
}
