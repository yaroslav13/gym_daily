import 'package:flutter/material.dart';
import 'package:gym_daily/src/features/extensions/theme_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:ui_components/ui_components.dart';

final class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBarHeight =
        Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ValueSelector(
                onChanged: (value) {},
                items: List.generate(
                  20,
                  (i) => i++,
                ),
              ),
            ),

            /// TODO: replace by the list of trainings
            Expanded(
              child: Container(
                color: context.colorScheme.surface,
                height: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
