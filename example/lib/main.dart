import 'package:analog_clock_example/demo.dart';
import 'package:flutter/material.dart';

import 'package:analog_clock/analog_clock.dart';

void main() => runApp(MyApp());
//void main() => runDemo();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
          home: Scaffold(
        body: AnalogClock(),
      ));
}
