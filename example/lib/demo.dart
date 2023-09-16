import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:analog_clock/analog_clock.dart';

void runDemo() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(const DemoApp());
}

class DemoApp extends StatefulWidget {
  const DemoApp({Key? key}) : super(key: key);

  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.amberAccent, Colors.amber])),
          child: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                lightClock,
                darkClock,
                simpleClock,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get lightClock => AnalogClock(
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        width: 150.0,
        showNumbers: false,
        showDigitalClock: false,
        dateTime: DateTime(2019, 1, 1, 10, 10, 35),
        key: const GlobalObjectKey(1),
      );

  Widget get darkClock => AnalogClock.dark(
      width: 250.0,
      dateTime: DateTime(2019, 1, 1, 12, 15, 45),
      key: const GlobalObjectKey(2),
      decoration:
          const BoxDecoration(color: Colors.black, shape: BoxShape.circle));

  Widget get simpleClock => AnalogClock(
        decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: Colors.black),
            color: Colors.transparent,
            shape: BoxShape.circle),
        width: 150.0,
        isLive: false,
        hourHandColor: Colors.black,
        minuteHandColor: Colors.black,
        showSecondHand: false,
        numberColor: Colors.black87,
        showNumbers: true,
        textScaleFactor: 1.4,
        showTicks: false,
        showDigitalClock: false,
        dateTime: DateTime(2019, 1, 1, 9, 12, 15),
        key: const GlobalObjectKey(3),
      );
}
