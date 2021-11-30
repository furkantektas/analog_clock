library analog_clock;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:analog_clock/analog_clock_painter.dart';

class AnalogClock extends StatefulWidget {
  final DateTime? datetime;
  final bool showDigitalClock;
  final bool showTicks;
  final bool showNumbers;
  final bool showAllNumbers;
  final bool showSecondHand;
  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;
  final Color tickColor;
  final Color digitalClockColor;
  final Color numberColor;
  final bool isLive;
  final double textScaleFactor;
  final double width;
  final double height;
  final BoxDecoration decoration;

  const AnalogClock(
      {this.datetime,
      this.showDigitalClock = true,
      this.showTicks = true,
      this.showNumbers = true,
      this.showSecondHand = true,
      this.showAllNumbers = false,
      this.hourHandColor = Colors.black,
      this.minuteHandColor = Colors.black,
      this.secondHandColor = Colors.redAccent,
      this.tickColor = Colors.grey,
      this.digitalClockColor = Colors.black,
      this.numberColor = Colors.black,
      this.textScaleFactor = 1.0,
      this.width = double.infinity,
      this.height = double.infinity,
      this.decoration = const BoxDecoration(),
      isLive,
      Key? key})
      : this.isLive = isLive ?? (datetime == null),
        super(key: key);

  const AnalogClock.dark(
      {datetime,
      showDigitalClock = true,
      showTicks = true,
      showNumbers = true,
      showAllNumbers = false,
      showSecondHand = true,
      width = double.infinity,
      height = double.infinity,
      decoration = const BoxDecoration(),
      Key? key})
      : this(
            datetime: datetime,
            showDigitalClock: showDigitalClock,
            showTicks: showTicks,
            showNumbers: showNumbers,
            showAllNumbers: showAllNumbers,
            showSecondHand: showSecondHand,
            width: width,
            height: height,
            hourHandColor: Colors.white,
            minuteHandColor: Colors.white,
            secondHandColor: Colors.redAccent,
            tickColor: Colors.grey,
            digitalClockColor: Colors.white,
            numberColor: Colors.white,
            decoration: decoration,
            key: key);

  @override
  _AnalogClockState createState() => _AnalogClockState(datetime);
}

class _AnalogClockState extends State<AnalogClock> {
  DateTime datetime;

  _AnalogClockState(datetime) : this.datetime = datetime ?? DateTime.now();

  initState() {
    super.initState();
    if (widget.isLive) {
      // update clock every second or minute based on second hand's visibility.
      Duration updateDuration =
          widget.showSecondHand ? Duration(seconds: 1) : Duration(minutes: 1);
      Timer.periodic(updateDuration, update);
    }
  }

  update(Timer timer) {
    if (mounted) {
      // update is only called on live clocks. So, it's safe to update datetime.
      datetime = DateTime.now();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: widget.decoration,
      child: Center(
          child: AspectRatio(
              aspectRatio: 1.0,
              child: new Container(
                  constraints: BoxConstraints(minWidth: 48.0, minHeight: 48.0),
                  width: double.infinity,
                  child: new CustomPaint(
                    painter: new AnalogClockPainter(
                        datetime: datetime,
                        showDigitalClock: widget.showDigitalClock,
                        showTicks: widget.showTicks,
                        showNumbers: widget.showNumbers,
                        showAllNumbers: widget.showAllNumbers,
                        showSecondHand: widget.showSecondHand,
                        hourHandColor: widget.hourHandColor,
                        minuteHandColor: widget.minuteHandColor,
                        secondHandColor: widget.secondHandColor,
                        tickColor: widget.tickColor,
                        digitalClockColor: widget.digitalClockColor,
                        textScaleFactor: widget.textScaleFactor,
                        numberColor: widget.numberColor),
                  )))),
    );
  }
}
