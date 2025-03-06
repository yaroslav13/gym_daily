import 'package:flutter/material.dart';

@immutable
final class BorderSideProperty implements WidgetStateProperty<BorderSide> {
  const BorderSideProperty({
    required this.enabled,
    required this.disabled,
    required this.borderWidth,
  });

  final Color enabled;
  final Color disabled;

  final double borderWidth;

  @override
  BorderSide resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return BorderSide(color: disabled, width: borderWidth);
    }

    return BorderSide(color: enabled, width: borderWidth);
  }
}
