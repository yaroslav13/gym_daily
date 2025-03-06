import 'package:flutter/material.dart';
import 'package:ui_components/theme/colors/gp_colors.dart';

@immutable
final class GPRadioFillColorProperty implements WidgetStateProperty<Color> {
  const GPRadioFillColorProperty(this._colors);

  final GPColors _colors;

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.selected)) {
      if (states.contains(WidgetState.disabled)) {
        return _colors.onSurface.withValues(alpha: 0.38);
      }

      if (states.contains(WidgetState.pressed)) {
        return _colors.brand;
      }

      if (states.contains(WidgetState.hovered)) {
        return _colors.brand;
      }

      if (states.contains(WidgetState.focused)) {
        return _colors.brand;
      }

      return _colors.brand;
    }

    if (states.contains(WidgetState.disabled)) {
      return _colors.onSurface.withValues(alpha: 0.38);
    }

    if (states.contains(WidgetState.pressed)) {
      return _colors.onSurface;
    }

    if (states.contains(WidgetState.hovered)) {
      return _colors.onSurface;
    }

    if (states.contains(WidgetState.focused)) {
      return _colors.onSurface;
    }

    return _colors.onSurfaceVariant;
  }
}
