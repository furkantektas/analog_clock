# Flutter Analog Clock Widget
[![pub package](https://img.shields.io/pub/v/analog_clock.svg)](https://pub.dartlang.org/packages/analog_clock)

Clean and fully customizable analog clock widget.

![Flutter Analog Clock Screenshot](https://github.com/furkantektas/analog_clock/raw/master/doc/sample_screenshot.png?raw=true)


## Installation

In your `pubspec.yaml` file within your Flutter Project:

```yaml
dependencies:
  analog_clock: ^0.0.1
```

## Features

- Modern and clean analog clock interface.
- Fully customizable.
- Live clock.
- Custom datetime.

## Usage

```dart
import 'package:analog_clock/analog_clock.dart';


AnalogClock(
	decoration: BoxDecoration(
	    border: Border.all(width: 2.0, color: Colors.black),
	    color: Colors.transparent,
	    shape: BoxShape.circle),
	width: 150.0,
	isLive: true,
	hourHandColor: Colors.black,
	minuteHandColor: Colors.black,
	showSecondHand: false,
	numberColor: Colors.black87,
	showNumbers: true,
	textScaleFactor: 1.4,
	showTicks: false,
	showDigitalClock: false,
	datetime: DateTime(2019, 1, 1, 9, 12, 15),
	);
```

## Parameters


![Flutter Analog Clock Parameters](https://github.com/furkantektas/analog_clock/raw/master/doc/visual_doc.png?raw=true)


## Example

Demo app can be found in the [`example/`](https://github.com/furkantektas/analog_clock/tree/master/example) folder.
