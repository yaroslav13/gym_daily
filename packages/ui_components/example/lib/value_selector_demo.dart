import 'package:ui_components/ui_components.dart';
import 'package:flutter/cupertino.dart';

class ValueSelectorDemo extends StatelessWidget {
  const ValueSelectorDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueSelector<int>(
        onChanged: (value) {},
        items: List.generate(100, (i) => i++),
      ),
    );
  }
}
