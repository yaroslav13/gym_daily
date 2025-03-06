import 'dart:ui';

import 'package:flutter/foundation.dart';

@immutable
final class GPColors {
  const GPColors({
    required this.brand,
    required this.onBrand,
    required this.accent,
    required this.onAccent,
    required this.supportive,
    required this.surface,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.error,
  });

  static const light = GPColors(
    brand: _blue,
    onBrand: _white,
    accent: _darkOrange,
    onAccent: _white,
    supportive: _malachite,
    surface: _white,
    onSurface: _chineseBlack,
    onSurfaceVariant: _grey,
    error: _malachite,
  );

  final Color brand;
  final Color onBrand;

  final Color accent;
  final Color onAccent;

  final Color supportive;

  final Color surface;
  final Color onSurface;
  final Color onSurfaceVariant;

  final Color error;

  static const _blue = Color(0xff0000FF);
  static const _darkOrange = Color(0xffFF8F00);
  static const _malachite = Color(0xff00C853);
  static const _grey = Color(0xffA0A5B0);
  static const _chineseBlack = Color(0xff0A1128);
  static const _white = Color(0xffFFFFFF);
}
