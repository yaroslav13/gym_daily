import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:ui_components/theme/theme_shortcuts_extension.dart';

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
              child: SfDateRangePicker(
                headerHeight: appBarHeight,
                initialSelectedDate: DateTime.now(),
                headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: context.materialColorScheme.surface,
                ),
                todayHighlightColor: context.materialColorScheme.primary,
                backgroundColor: context.materialColorScheme.surface,
                selectionColor: context.materialColorScheme.primary,
                selectionShape: DateRangePickerSelectionShape.rectangle,
              ),
            ),

            /// TODO: replace by the list of trainings
            Expanded(
              child: Container(
                color: context.materialColorScheme.surface,
                height: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
