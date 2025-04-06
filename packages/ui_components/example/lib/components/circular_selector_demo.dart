import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';

class CircularSelectorDemo extends StatelessWidget {
  const CircularSelectorDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final themeSwitchingNotifier = ValueNotifier(Brightness.light);
    final valueCountNotifier = ValueNotifier(5);
    final initialValueNotifier = ValueNotifier(0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CircularSelector Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder(
          valueListenable: themeSwitchingNotifier,
          builder: (context, brightness, child) => Theme(
            data: Theme.of(context).copyWith(brightness: brightness),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Change theme '),
                      Switch(
                        value: brightness == Brightness.light,
                        onChanged: (value) => themeSwitchingNotifier.value =
                            value ? Brightness.light : Brightness.dark,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ValueListenableBuilder(
                    valueListenable: valueCountNotifier,
                    builder: (_, valuesCount, __) => ValueListenableBuilder(
                      valueListenable: initialValueNotifier,
                      builder: (_, initialValue, __) =>
                          CircularValueSelector<int>(
                        onChanged: (value) {},
                        items: List.generate(
                          valuesCount,
                          (i) => i++,
                        ),
                        initialItemIndex: initialValue,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: valueCountNotifier,
                        builder: (_, value, __) => Column(
                          children: [
                            Text('Values Count $value'),
                            Slider(
                              value: value.toDouble(),
                              min: 5,
                              max: 300,
                              onChanged: (count) {
                                if (count < initialValueNotifier.value) {
                                  initialValueNotifier.value =
                                      count.toInt() - 1;
                                }
                                valueCountNotifier.value = count.toInt();
                              },
                            ),
                          ],
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: valueCountNotifier,
                        builder: (_, valuesCount, __) => ValueListenableBuilder(
                          valueListenable: initialValueNotifier,
                          builder: (_, initialValue, __) {
                            final value =
                                min(initialValue.toDouble(), valuesCount)
                                    .toDouble();
                            return Column(
                              children: [
                                Text('Initial Value Index $value'),
                                Slider(
                                  label: '$value',
                                  value: value,
                                  max: valuesCount.toDouble(),
                                  onChanged: (count) => initialValueNotifier
                                      .value = count.toInt(),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
