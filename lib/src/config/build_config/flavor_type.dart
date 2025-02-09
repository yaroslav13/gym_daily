import 'package:flutter/services.dart';

enum FlavorType {
  prod('prod'),
  dev('dev');

  const FlavorType(this.name);

  final String name;

  static FlavorType get fromEnvironment {
    final type = FlavorType.values.firstWhere(
      (type) => type.name == appFlavor,
      orElse: () => throw Exception('Unsupported build_config $appFlavor.'),
    );

    return type;
  }
}
