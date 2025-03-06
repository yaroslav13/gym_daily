import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_components/ui_components.dart';

part 'theme_provider.g.dart';

/// The [theme] is pattern for riverpod_generator.
/// It returns the [ThemeData] configuration of the app.
@riverpod
ThemeData theme(Ref ref) {
  return const GPTheme.light().data;
}
