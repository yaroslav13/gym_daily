import 'package:example/value_selector_demo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _destination = 0;
  final _destinations = const <Widget>[
    ValueSelectorDemo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          NavigationRail(
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.design_services),
                label: Text(
                  'ValueSelector',
                ),
              )
            ],
            selectedIndex: 0,
            onDestinationSelected: (int index) {
              setState(() {
                _destination = index;
              });
            },
          ),
          VerticalDivider(width: 1, thickness: 1, color: Colors.grey[300]),
          Expanded(
            child: _destinations.isNotEmpty
                ? _destinations[_destination]
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
