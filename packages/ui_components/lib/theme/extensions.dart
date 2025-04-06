import 'package:flutter/material.dart';

extension ColorX on Color {
  Color applyOpacity(double opacity) {
    return withAlpha((opacity * 255).round());
  }
}
