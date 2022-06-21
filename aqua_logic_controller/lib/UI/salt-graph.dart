import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SaltGraph extends StatelessWidget {
  final List<SaltLevel> data;
  final bool? animate;

  const SaltGraph(this.data, {this.animate});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<SaltLevel, DateTime>> series = [
      charts.Series(
          id: "Salt Level",
          data: data,
          domainFn: (SaltLevel series, _) => series.date,
          measureFn: (SaltLevel series, _) => series.ppm,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Theme.of(context).colorScheme.secondary),
      )
    ];

    return new charts.TimeSeriesChart(
      series,
      animate: animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      defaultRenderer: new charts.LineRendererConfig<DateTime>(includePoints: true),
      domainAxis: new charts.DateTimeAxisSpec(
        tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
          day: new charts.TimeFormatterSpec(
            format: 'MMM yyyy',
            transitionFormat: 'MMM yyyy',
          ),
        ),
      ),
    );
  }
}

class SaltLevel {
  final DateTime date;
  final int ppm;

  SaltLevel(this.date, this.ppm);
}
