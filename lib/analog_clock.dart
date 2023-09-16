library analog_clock;

import 'dart:async';
import 'package:flutter/material.dart';
import 'analog_clock_painter.dart';

class AnalogClock extends StatefulWidget {
  final DateTime? dateTime;
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
  final BoxDecoration decoration;

  const AnalogClock(
      {this.dateTime,
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
      this.width = double.infinity,
      this.height = double.infinity,
      this.decoration = const BoxDecoration(),
      isLive,
      Key? key})
      : isLive = isLive ?? (dateTime == null),
        super(key: key);

  const AnalogClock.dark(
      {dateTime,
      showDigitalClock = true,
      showTicks = true,
      showNumbers = true,
      showAllNumbers = false,
      showSecondHand = true,
      useMilitaryTime = true,
      width = double.infinity,
      height = double.infinity,
      decoration = const BoxDecoration(),
      Key? key})
      : this(
            dateTime: dateTime,
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
  _AnalogClockState createState() => _AnalogClockState(dateTime);
}

class _AnalogClockState extends State<AnalogClock> {
  DateTime initialDateTime; // to keep track of time changes
  DateTime dateTime;
  Duration updateDuration = const Duration(seconds: 1); // repaint frequency
  _AnalogClockState(dateTime)
      : dateTime = dateTime ?? DateTime.now(),
        initialDateTime = dateTime ?? DateTime.now();

  @override
  initState() {
    super.initState();
    // repaint the clock every second if second-hand or digital-clock are shown
    updateDuration = widget.showSecondHand || widget.showDigitalClock
        ? const Duration(seconds: 1)
        : const Duration(minutes: 1);

    if (widget.isLive) {
      // update clock every second or minute based on second hand's visibility.
      Timer.periodic(updateDuration, update);
    }
  }

  update(Timer timer) {
    if (mounted) {
      // update is only called on live clocks. So, it's safe to update dateTime.
      dateTime = initialDateTime.add(updateDuration * timer.tick);
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
              child: Container(
                  constraints:
                      const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
                  width: double.infinity,
                  child: CustomPaint(
                    painter: AnalogClockPainter(
                        dateTime: dateTime,
                        showDigitalClock: widget.showDigitalClock,
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
                        numberColor: widget.numberColor),
                  )))),
    );
  }

  @override
  void didUpdateWidget(AnalogClock oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.isLive && widget.dateTime != oldWidget.dateTime) {
      dateTime = widget.dateTime ?? DateTime.now();
    }
  }
}
