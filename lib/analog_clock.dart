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
  final bool useMilitaryTime;
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
  final double strokeWidth;
  final BoxDecoration decoration;

  // Allows user to animate the second hand
  final bool animateSecondHand;

  const AnalogClock(
      {this.datetime,
      this.showDigitalClock = true,
      this.showTicks = true,
      this.showNumbers = true,
      this.showSecondHand = true,
      this.showAllNumbers = false,
      this.useMilitaryTime = true,
      this.hourHandColor = Colors.black,
      this.minuteHandColor = Colors.black,
      this.secondHandColor = Colors.redAccent,
      this.tickColor = Colors.grey,
      this.digitalClockColor = Colors.black,
      this.numberColor = Colors.black,
      this.textScaleFactor = 1.0,
      this.strokeWidth = 3.0,
      this.width = double.infinity,
      this.height = double.infinity,
      this.animateSecondHand = false,
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
      useMilitaryTime = true,
      animateSecondHand = false,
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
            useMilitaryTime: useMilitaryTime,
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
  DateTime initialDatetime; // to keep track of time changes
  DateTime datetime;
  Duration updateDuration = const Duration(seconds: 1); // repaint frequency
  _AnalogClockState(datetime)
      : this.datetime = datetime ?? DateTime.now(),
        initialDatetime = datetime ?? DateTime.now();

  initState() {
    super.initState();
    // repaint the clock every second if second-hand or digital-clock are shown
    updateDuration = widget.showSecondHand || widget.showDigitalClock
        ? widget.animateSecondHand
            ? Duration(milliseconds: 50)
            : Duration(seconds: 1)
        : Duration(minutes: 1);

    if (widget.isLive) {
      // update clock every second or minute based on second hand's visibility.
      Timer.periodic(updateDuration, update);
    }
  }

  update(Timer timer) {
    if (mounted) {
      // update is only called on live clocks. So, it's safe to update datetime.
      this.datetime = this.initialDatetime.add(updateDuration * timer.tick);
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
                      strokeWidth: widget.strokeWidth,
                      showTicks: widget.showTicks,
                      showNumbers: widget.showNumbers,
                      showAllNumbers: widget.showAllNumbers,
                      showSecondHand: widget.showSecondHand,
                      useMilitaryTime: widget.useMilitaryTime,
                      hourHandColor: widget.hourHandColor,
                      minuteHandColor: widget.minuteHandColor,
                      secondHandColor: widget.secondHandColor,
                      tickColor: widget.tickColor,
                      digitalClockColor: widget.digitalClockColor,
                      textScaleFactor: widget.textScaleFactor,
                      numberColor: widget.numberColor,
                      animateSecondHand: widget.animateSecondHand,
                    ),
                  )))),
    );
  }

  @override
  void didUpdateWidget(AnalogClock oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.isLive && widget.datetime != oldWidget.datetime) {
      datetime = widget.datetime ?? DateTime.now();
    }
  }
}
