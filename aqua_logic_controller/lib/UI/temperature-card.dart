import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TemperatureCard extends StatefulWidget {
  final String display;
  final int? temp;
  final bool isMetric;

  const TemperatureCard(
      {Key? key,
      required this.display,
      required this.temp,
      required this.isMetric})
      : super(key: key);

  @override
  _TemperatureCardState createState() => _TemperatureCardState();
}

class _TemperatureCardState extends State<TemperatureCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Container(
          width: 120,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: new FittedBox(
                    fit: BoxFit.fill,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: temperatureToIcon(),
                    ),
                  ),
                ),
                Text(
                  widget.display,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  widget.temp == null
                      ? "Unknown"
                      : widget.temp.toString() +
                          (widget.isMetric ? "\u2103" : "\u2109"),
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Icon temperatureToIcon() {
    if (widget.temp == null) {
      return Icon(CupertinoIcons.question);
    }

    int celsius = widget.temp!;

    if (!widget.isMetric) {
      celsius = ((widget.temp! - 32) * 5 / 9).floor();
    }

    if (celsius > 25) {
      return Icon(CupertinoIcons.thermometer_sun);
    } else if (celsius < 15) {
      return Icon(CupertinoIcons.thermometer_snowflake);
    }

    return Icon(CupertinoIcons.thermometer);
  }
}
