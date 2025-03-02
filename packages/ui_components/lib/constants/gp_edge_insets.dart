import 'package:flutter/material.dart';

abstract final class GPEdgeInsets {
  const GPEdgeInsets._();

  static const scaffoldBody = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 12,
  );

  static const horizontal = EdgeInsets.symmetric(
    horizontal: 24,
  );
}
