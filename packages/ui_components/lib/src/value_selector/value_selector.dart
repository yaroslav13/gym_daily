import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_components/src/value_selector/value_selector_theme_data.dart';

class ValueSelector<T> extends StatefulWidget {
  const ValueSelector({
    required this.onChanged,
    required this.items,
    this.currentItemBuilder,
    this.dimension = 300,
    super.key,
  });

  final ValueChanged<T> onChanged;
  final List<T> items;

  final Widget Function(T item)? currentItemBuilder;
  final double dimension;

  @override
  State<StatefulWidget> createState() {
    return _ValueSelectorState<T>();
  }
}

class _ValueSelectorState<T> extends State<ValueSelector<T>>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late double _angle;
  final double _controllerDimension = 30;
  late Offset _controlPosition;
  late Offset _startDragPosition;
  late double _startDragAngle;
  int _lastHapticIndex = 0;

  late AnimationController _animationController;
  late Animation<double> _snapAnimation;

  @override
  void initState() {
    super.initState();
    _angle = _indexToAngle(_currentIndex);
    _updateControlPosition();

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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double _indexToAngle(int index) {
    return (index / widget.items.length) * 2 * pi - pi / 2;
  }

  void _updateControlPosition() {
    final radius = widget.dimension / 2 - _controllerDimension / 2;
    final centerX = widget.dimension / 2;
    final centerY = widget.dimension / 2;

    final x = centerX + radius * cos(_angle);
    final y = centerY + radius * sin(_angle);

    _controlPosition =
        Offset(x - _controllerDimension / 2, y - _controllerDimension / 2);
  }

  void _onPanStart(DragStartDetails details) {
    _animationController.stop();

    _startDragPosition = details.localPosition;
    _startDragAngle = _angle;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final centerX = widget.dimension / 2;
    final centerY = widget.dimension / 2;

    final startDx = _startDragPosition.dx - centerX;
    final startDy = _startDragPosition.dy - centerY;
    final startAngle = atan2(startDy, startDx);

    final currentDx = details.localPosition.dx - centerX;
    final currentDy = details.localPosition.dy - centerY;
    final currentAngle = atan2(currentDy, currentDx);

    var deltaAngle = currentAngle - startAngle;
    var newAngle = _startDragAngle + deltaAngle;

    setState(() {
      _angle = newAngle;
      _updateControlPosition();
      _updateCurrentIndexWithHaptic(false);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    var normalizedAngle = _angle;
    if (normalizedAngle < -pi / 2) normalizedAngle += 2 * pi;
    normalizedAngle = (normalizedAngle + pi / 2) % (2 * pi);

    final segmentSize = 2 * pi / widget.items.length;
    int nearestIndex =
        (normalizedAngle / segmentSize).round() % widget.items.length;

    final idealAngle = _indexToAngle(nearestIndex);

    double normalizedCurrentAngle = _angle % (2 * pi);
    if (normalizedCurrentAngle < 0) normalizedCurrentAngle += 2 * pi;

    double normalizedIdealAngle = idealAngle % (2 * pi);
    if (normalizedIdealAngle < 0) normalizedIdealAngle += 2 * pi;

    double angleDiff = normalizedIdealAngle - normalizedCurrentAngle;

    if (angleDiff > pi) {
      angleDiff -= 2 * pi;
    } else if (angleDiff < -pi) {
      angleDiff += 2 * pi;
    }

    double targetAngle = _angle + angleDiff;

    if (nearestIndex != _currentIndex) {
      setState(() {
        _currentIndex = nearestIndex;
      });
      widget.onChanged.call(widget.items[_currentIndex]);
    }

    _snapAnimation = Tween<double>(
      begin: _angle,
      end: targetAngle,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _animationController.reset();
    _animationController.forward();
  }

  void _updateCurrentIndexWithHaptic(bool animate) {
    var normalizedAngle = _angle;
    if (normalizedAngle < -pi / 2) normalizedAngle += 2 * pi;

    normalizedAngle = (normalizedAngle + pi / 2) % (2 * pi);

    final segmentSize = 2 * pi / widget.items.length;
    int index = (normalizedAngle / segmentSize).floor() % widget.items.length;
    if (_lastHapticIndex != _currentIndex) {
      HapticFeedback.lightImpact();
      _lastHapticIndex = _currentIndex;
    }
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });

      widget.onChanged.call(widget.items[_currentIndex]);

      // Анимируем к точной позиции, если нужно
      if (animate) {
        final idealAngle = _indexToAngle(_currentIndex);

        _snapAnimation = Tween<double>(
          begin: _angle,
          end: idealAngle,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOutBack,
        ));

        _animationController.reset();
        _animationController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ValueSelectorThemeData.of(context);
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: LimitedBox(
        child: SizedBox.square(
          dimension: widget.dimension,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.dimension / 2),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: theme.slideSurfaceGradient,
                boxShadow: theme.slideSurfaceBoxShadow,
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: _controlPosition.dy,
                    left: _controlPosition.dx,
                    child: GestureDetector(
                      onPanStart: _onPanStart,
                      onPanUpdate: _onPanUpdate,
                      onPanEnd: _onPanEnd,
                      child: _ValueSelectorControl(
                        controlDimension: _controllerDimension,
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox.square(
                      dimension: widget.dimension * 0.75,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400
                                  .withAlpha((255.0 * 0.3).round()),
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Center(
                          child: widget.currentItemBuilder
                                  ?.call(widget.items[_currentIndex]) ??
                              Text(
                                widget.items[_currentIndex].toString(),
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanStart: _onPanStart,
                      onPanUpdate: _onPanUpdate,
                      onPanEnd: _onPanEnd,
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

class _ValueSelectorControl extends StatelessWidget {
  const _ValueSelectorControl({
    required this.controlDimension,
  });

  final double controlDimension;

  @override
  Widget build(BuildContext context) {
    final theme = ValueSelectorThemeData.of(context);

    return SizedBox.square(
      dimension: controlDimension,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.selectorBackgroundColor,
          shape: BoxShape.circle,
          boxShadow: theme.selectorBoxShadow,
        ),
      ),
    );
  }
}
