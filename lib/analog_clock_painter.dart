import 'package:flutter/material.dart';
import 'dart:math';

class AnalogClockPainter extends CustomPainter {
  DateTime datetime;
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
  final double textScaleFactor;

  static const double BASE_SIZE = 320.0;
  static const double MINUTES_IN_HOUR = 60.0;
  static const double SECONDS_IN_MINUTE = 60.0;
  static const double HOURS_IN_CLOCK = 12.0;
  static const double HAND_PIN_HOLE_SIZE = 8.0;
  static const double STROKE_WIDTH = 3.0;

  AnalogClockPainter(
      {@required this.datetime,
      this.showDigitalClock = true,
      this.showTicks = true,
      this.showNumbers = true,
      this.showSecondHand = true,
      this.hourHandColor = Colors.black,
      this.minuteHandColor = Colors.black,
      this.secondHandColor = Colors.redAccent,
      this.tickColor = Colors.grey,
      this.digitalClockColor = Colors.black,
      this.numberColor = Colors.black,
      this.showAllNumbers = false,
      this.textScaleFactor = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    double scaleFactor = size.shortestSide / BASE_SIZE;

    if (showTicks) _paintTickMarks(canvas, size, scaleFactor);
    if (showNumbers) _drawIndicators(canvas, size, scaleFactor);
    if (showAllNumbers) _drawAllIndicators(canvas, size, scaleFactor);
    if (showDigitalClock) _paintDigitalClock(canvas, size, scaleFactor);

    _paintClockHands(canvas, size, scaleFactor);
    _paintPinHole(canvas, size, scaleFactor);
  }

  @override
  bool shouldRepaint(AnalogClockPainter oldDelegate) {
    return oldDelegate?.datetime?.isBefore(datetime) ?? true;
  }

  _paintPinHole(canvas, size, scaleFactor) {
    Paint midPointStrokePainter = Paint()
      ..color = showSecondHand ? secondHandColor : minuteHandColor
      ..strokeWidth = STROKE_WIDTH * scaleFactor
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero),
        HAND_PIN_HOLE_SIZE * scaleFactor, midPointStrokePainter);
  }

  void _drawIndicators(Canvas canvas, Size size, double scaleFactor) {
    TextStyle style = TextStyle(
        color: numberColor,
        fontWeight: FontWeight.bold,
        fontSize: 18.0 * scaleFactor * textScaleFactor);
    double p = 4.0;
    if (showTicks) p += 24.0;
    Offset paddingX = Offset(p * scaleFactor, 0.0);
    Offset paddingY = Offset(0.0, p * scaleFactor);

    TextSpan span12 = new TextSpan(style: style, text: "12");
    TextPainter tp12 = new TextPainter(
        text: span12,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp12.layout();
    tp12.paint(canvas, size.topCenter(-tp12.size.topCenter(-paddingY)));

    TextSpan span6 = new TextSpan(style: style, text: "6");
    TextPainter tp6 = new TextPainter(
        text: span6,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp6.layout();
    tp6.paint(canvas, size.bottomCenter(-tp6.size.bottomCenter(paddingY)));

    TextSpan span3 = new TextSpan(style: style, text: "3");
    TextPainter tp3 = new TextPainter(
        text: span3,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp3.layout();
    tp3.paint(canvas, size.centerRight(-tp3.size.centerRight(paddingX)));

    TextSpan span9 = new TextSpan(style: style, text: "9");
    TextPainter tp9 = new TextPainter(
        text: span9,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp9.layout();
    tp9.paint(canvas, size.centerLeft(-tp9.size.centerLeft(-paddingX)));
  }

  void _drawAllIndicators(Canvas canvas, Size size, double scaleFactor) {
    TextStyle style = TextStyle(
        color: numberColor,
        fontWeight: FontWeight.bold,
        fontSize: 18.0 * scaleFactor * textScaleFactor);
    double p = 4.0;
    if (showTicks) p += 24.0;
    Offset paddingX = Offset(p * scaleFactor, 0.0);
    Offset paddingY = Offset(0.0, p * scaleFactor);
    Offset paddingY_1 = Offset(scaleFactor * 65.0, p * scaleFactor / 0.63);
    Offset paddingX_2 = Offset(p * scaleFactor / 0.26, scaleFactor * 90);
    Offset paddingY_7 = Offset(-(scaleFactor * 60), (p * scaleFactor * 9.15));
    Offset paddingX_8 = Offset(-(p * scaleFactor * 3.8), scaleFactor * 210);
    Offset paddingY_11 = Offset(scaleFactor * 60.0, -(p * scaleFactor * 1.6));
    Offset paddingX_10 = Offset(p * scaleFactor * 3.8, -(scaleFactor * 90));
    Offset paddingY_4 = Offset(scaleFactor * 48, -(p * scaleFactor * 2.2));
    Offset paddingX_5 = Offset(p * scaleFactor * 3.4, -(scaleFactor * 105));

    TextSpan span10 = new TextSpan(style: style, text: "10");
    TextPainter tp10 = new TextPainter(
        text: span10,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp10.layout();
    tp10.paint(canvas, size.topCenter(-tp10.size.topCenter(paddingX_10)));

    TextSpan span11 = new TextSpan(style: style, text: "11");
    TextPainter tp11 = new TextPainter(
        text: span11,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp11.layout();
    tp11.paint(canvas, size.topCenter(-tp11.size.topCenter(paddingY_11)));

    TextSpan span12 = new TextSpan(style: style, text: "12");
    TextPainter tp12 = new TextPainter(
        text: span12,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp12.layout();
    tp12.paint(canvas, size.topCenter(-tp12.size.topCenter(-paddingY)));

    TextSpan span1 = new TextSpan(style: style, text: "1");
    TextPainter tp1 = new TextPainter(
        text: span1,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp1.layout();
    tp1.paint(canvas, size.topCenter(-tp1.size.topCenter(-paddingY_1)));

    TextSpan span2 = new TextSpan(style: style, text: "2");
    TextPainter tp2 = new TextPainter(
        text: span2,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp2.layout();
    tp2.paint(canvas, size.topCenter(-tp2.size.topCenter(-paddingX_2)));

    TextSpan span6 = new TextSpan(style: style, text: "6");
    TextPainter tp6 = new TextPainter(
        text: span6,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp6.layout();
    tp6.paint(canvas, size.bottomCenter(-tp6.size.bottomCenter(paddingY)));

    TextSpan span7 = new TextSpan(style: style, text: "7");
    TextPainter tp7 = new TextPainter(
        text: span7,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp7.layout();
    tp7.paint(canvas, size.topCenter(-tp7.size.topCenter(-paddingY_7)));

    TextSpan span8 = new TextSpan(style: style, text: "8");
    TextPainter tp8 = new TextPainter(
        text: span8,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp8.layout();
    tp8.paint(canvas, size.topCenter(-tp8.size.topCenter(-paddingX_8)));

    TextSpan span3 = new TextSpan(style: style, text: "3");
    TextPainter tp3 = new TextPainter(
        text: span3,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp3.layout();
    tp3.paint(canvas, size.centerRight(-tp3.size.centerRight(paddingX)));

    TextSpan span4 = new TextSpan(style: style, text: "4");
    TextPainter tp4 = new TextPainter(
        text: span4,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp4.layout();
    tp4.paint(canvas, size.centerRight(-tp4.size.centerRight(paddingY_4)));

    TextSpan span5 = new TextSpan(style: style, text: "5");
    TextPainter tp5 = new TextPainter(
        text: span5,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp5.layout();
    tp5.paint(canvas, size.centerRight(-tp5.size.centerRight(paddingX_5)));

    TextSpan span9 = new TextSpan(style: style, text: "9");
    TextPainter tp9 = new TextPainter(
        text: span9,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp9.layout();
    tp9.paint(canvas, size.centerLeft(-tp9.size.centerLeft(-paddingX)));
  }

  Offset _getHandOffset(double percentage, double length) {
    final radians = 2 * pi * percentage;
    final angle = -pi / 2.0 + radians;

    return new Offset(length * cos(angle), length * sin(angle));
  }

  // ref: https://www.codenameone.com/blog/codename-one-graphics-part-2-drawing-an-analog-clock.html
  void _paintTickMarks(Canvas canvas, Size size, double scaleFactor) {
    double r = size.shortestSide / 2;
    double tick = 5 * scaleFactor,
        mediumTick = 2.0 * tick,
        longTick = 3.0 * tick;
    double p = longTick + 4 * scaleFactor;
    Paint tickPaint = Paint()
      ..color = tickColor
      ..strokeWidth = 2.0 * scaleFactor;

    for (int i = 1; i <= 60; i++) {
      // default tick length is short
      double len = tick;
      if (i % 15 == 0) {
        // Longest tick on quarters (every 15 ticks)
        len = longTick;
      } else if (i % 5 == 0) {
        // Medium ticks on the '5's (every 5 ticks)
        len = mediumTick;
      }
      // Get the angle from 12 O'Clock to this tick (radians)
      double angleFrom12 = i / 60.0 * 2.0 * pi;

      // Get the angle from 3 O'Clock to this tick
      // Note: 3 O'Clock corresponds with zero angle in unit circle
      // Makes it easier to do the math.
      double angleFrom3 = pi / 2.0 - angleFrom12;

      canvas.drawLine(
          size.center(Offset(cos(angleFrom3) * (r + len - p),
              sin(angleFrom3) * (r + len - p))),
          size.center(
              Offset(cos(angleFrom3) * (r - p), sin(angleFrom3) * (r - p))),
          tickPaint);
    }
  }

  void _paintClockHands(Canvas canvas, Size size, double scaleFactor) {
    double r = size.shortestSide / 2;
    double p = 0.0;
    if (showTicks) p += 28.0;
    if (showNumbers) p += 24.0;
    if (showAllNumbers) p += 24.0;
    double longHandLength = r - (p * scaleFactor);
    double shortHandLength = r - (p + 36.0) * scaleFactor;

    Paint handPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.bevel
      ..strokeWidth = STROKE_WIDTH * scaleFactor;
    double seconds = datetime.second / SECONDS_IN_MINUTE;
    double minutes = (datetime.minute + seconds) / MINUTES_IN_HOUR;
    double hour = (datetime.hour + minutes) / HOURS_IN_CLOCK;

    canvas.drawLine(
        size.center(_getHandOffset(hour, HAND_PIN_HOLE_SIZE * scaleFactor)),
        size.center(_getHandOffset(hour, shortHandLength)),
        handPaint..color = hourHandColor);

    canvas.drawLine(
        size.center(_getHandOffset(minutes, HAND_PIN_HOLE_SIZE * scaleFactor)),
        size.center(_getHandOffset(minutes, longHandLength)),
        handPaint..color = minuteHandColor);
    if (showSecondHand)
      canvas.drawLine(
          size.center(
              _getHandOffset(seconds, HAND_PIN_HOLE_SIZE * scaleFactor)),
          size.center(_getHandOffset(seconds, longHandLength)),
          handPaint..color = secondHandColor);
  }

  void _paintDigitalClock(Canvas canvas, Size size, double scaleFactor) {
    String hour = datetime.hour.toString().padLeft(2, "0");
    String minute = datetime.minute.toString().padLeft(2, "0");
    String second = datetime.second.toString().padLeft(2, "0");
    TextSpan digitalClockSpan = new TextSpan(
        style: TextStyle(
            color: digitalClockColor,
            fontSize: 18 * scaleFactor * textScaleFactor),
        text: "$hour:$minute:$second");
    TextPainter digitalClockTP = new TextPainter(
        text: digitalClockSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    digitalClockTP.layout();
    digitalClockTP.paint(
        canvas,
        size.center(
            -digitalClockTP.size.center(Offset(0.0, -size.shortestSide / 6))));
  }
}
