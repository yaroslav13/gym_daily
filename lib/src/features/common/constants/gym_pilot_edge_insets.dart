import 'package:flutter/material.dart';

extension type const GymPilotEdgeInsets(EdgeInsets _) implements EdgeInsets {
  const GymPilotEdgeInsets.bodyInsets()
      : this(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        );

  const GymPilotEdgeInsets.horizontalInsets()
      : this(
          const EdgeInsets.symmetric(horizontal: 24),
        );
}
