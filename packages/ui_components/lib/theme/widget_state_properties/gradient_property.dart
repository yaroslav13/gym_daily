import 'package:flutter/material.dart';

@immutable
final class GradientProperty implements WidgetStateProperty<LinearGradient> {
  const GradientProperty({
    required this.enabledColors,
    required this.disabledColors,
    required this.stops,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
  });

  final Alignment begin;
  final Alignment end;

  final List<Color> enabledColors;
  final List<Color> disabledColors;

  final List<double> stops;

  @override
  LinearGradient resolve(Set<WidgetState> states) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: states.contains(WidgetState.disabled)
          ? disabledColors
          : enabledColors,
      stops: stops,
    );
  }
}
