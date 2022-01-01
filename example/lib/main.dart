// import 'package:analog_clock_example/demo.dart';
import 'package:flutter/material.dart';

import 'package:analog_clock/analog_clock.dart';

void main() => runApp(const MyApp());
//void main() => runDemo();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => const MaterialApp(
          home: Scaffold(
        body: AnalogClock(),
      ));
}
