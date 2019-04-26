import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:analog_clock/analog_clock.dart';

void runDemo() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(DemoApp());
}

class DemoApp extends StatefulWidget {
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
              gradient: const LinearGradient(
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
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        width: 150.0,
        showNumbers: false,
        showDigitalClock: false,
        datetime: DateTime(2019, 1, 1, 10, 10, 35),
        key: GlobalObjectKey(1),
      );

  Widget get darkClock => AnalogClock.dark(
      width: 250.0,
      datetime: DateTime(2019, 1, 1, 12, 15, 45),
      key: GlobalObjectKey(2),
      decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle));

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
        datetime: DateTime(2019, 1, 1, 9, 12, 15),
        key: GlobalObjectKey(3),
      );
}
