import 'package:flutter/material.dart';
import 'package:ui_components/checkbox/gp_checkbox.dart';
import 'package:ui_components/elevated_button/gp_elevated_button.dart';
import 'package:ui_components/outlined_button/gp_outlined_button.dart';
import 'package:ui_components/radio/gp_radio.dart';
import 'package:ui_components/switcher/gp_switcher.dart';

final class KitsExample extends StatefulWidget {
  const KitsExample({super.key});

  @override
  State<KitsExample> createState() => _KitsExampleState();
}

final class _KitsExampleState extends State<KitsExample> {
  bool _switcherValue = true;
  bool _checkboxValue = true;
  bool _radioValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: [
            _Cell(
              title: 'Switcher',
              widget: GPSwitcher(
                value: _switcherValue,
                onChanged: (value) {
                  setState(() {
                    _switcherValue = value;
                  });
                },
              ),
            ),
            _Cell(
              title: 'Checkbox',
              widget: GPCheckbox(
                value: _checkboxValue,
                onChanged: (value) => setState(
                  () {
                    _checkboxValue = value;
                  },
                ),
              ),
            ),
            _Cell(
              title: 'Radio',
              widget: GPRadio<bool>(
                value: _radioValue,
                groupValue: true,
                toggleable: true,
                onChanged: (value) => setState(
                  () {
                    _radioValue = !_radioValue;
                  },
                ),
              ),
            ),
            _Cell(
              title: 'Elevated button',
              widget: GPElevetedButton(
                onPressed: () {},
                child: const Text('Play'),
              ),
            ),
            const _Cell(
              title: 'Elevated button (disabled)',
              widget: GPElevetedButton(
                onPressed: null,
                child: Text('Play'),
              ),
            ),
            _Cell(
              title: 'Outlined button',
              widget: GPOutlinedButton(
                onPressed: () {},
                child: const Text('Play'),
              ),
            ),
            const _Cell(
              title: 'Outlined button (disabled)',
              widget: GPOutlinedButton(
                onPressed: null,
                child: Text('Play'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _Cell extends StatelessWidget {
  const _Cell({
    required this.title,
    required this.widget,
  });

  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            widget,
          ],
        ),
      ),
    );
  }
}
