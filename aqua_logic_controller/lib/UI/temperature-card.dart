import 'package:flutter/material.dart';

class TemperatureCard extends StatefulWidget {
  final String display;
  final int? temp;
  final bool isMetric;
  const TemperatureCard({Key? key, required this.display, required this.temp, required this.isMetric}) : super(key: key);

  @override
  _TemperatureCardState createState() => _TemperatureCardState();
}

class _TemperatureCardState extends State<TemperatureCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      child: Card(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.thermostat, size: 64),
              Text(widget.display),
              Text(widget.temp == null ? "Unknown" : widget.temp.toString() + ' ' + (widget.isMetric ? "\u2103" : "\u2109"))
            ],
          ),
        ),
      ),
    );
  }
}
