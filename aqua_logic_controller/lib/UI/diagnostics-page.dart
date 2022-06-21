import 'package:aqua_logic_controller/Models/aqualogic_provider.dart';
import 'package:aqua_logic_controller/UI/blinking-text.dart';
import 'package:aqua_logic_controller/UI/salt-info.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:provider/provider.dart';

class Diagnostics extends StatelessWidget {
  const Diagnostics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: displayStatus(context.select(
                      (AquaLogicProvider value) => value.aquaLogic.status)),
                )
              ],
            ),
          ),
          FlipCard(
            fill: Fill.fillBack,
            direction: FlipDirection.HORIZONTAL,
            front: Card(
              child: Column(
                children: [
                  ListTile(
                    trailing: Icon(Icons.rotate_right),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: createGauge(
                          "Salt Level",
                          "ppm",
                          context.select((AquaLogicProvider value) =>
                              value.aquaLogic.saltLevel),
                          2700,
                          3600),
                    ),
                  )
                ],
              ),
            ),
            back: Card(child: SaltInfo()),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: createGauge(
                  "Pool Chlorination",
                  "%",
                  context.select((AquaLogicProvider value) =>
                      value.aquaLogic.poolChlorinatorPercent),
                  0,
                  100),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: createGauge(
                  "Spa Chlorination",
                  "%",
                  context.select((AquaLogicProvider value) =>
                      value.aquaLogic.spaChlorinatorPercent),
                  0,
                  100),
            ),
          )
        ],
      ),
    );
  }

  Widget createGauge(
      String label, String unit, num? value, double min, double max) {

    bool unknown = false;
    if (value == null) {
      unknown = true;
      value ??= 0;
    }

    double newMin = min;
    double newMax = max;

    if (min > 0 && value > 0) {
      value = value - min;
      newMax = max - min;
      newMin = 0;
    }

    return AnimatedRadialGauge(
      duration: const Duration(milliseconds: 500),
      value: value.toDouble(),
      min: newMin,
      max: newMax,
      axis: GaugeAxis(
        degrees: 200,
        transformer: GaugeAxisTransformer.progress(color: Colors.greenAccent),
        style: const GaugeAxisStyle(
          thickness: 12,
          background: Color(0xFFD9DEEB),
        ),
        pointer: RoundedTrianglePointer(
          size: 20,
          backgroundColor: Colors.black,
          borderRadius: 2,
          border: const GaugePointerBorder(
            color: Colors.white,
            width: 2,
          ),
        ),
      ),
      builder: (context, child, value) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            label,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          AutoSizeText(
            '${unknown ? "Unknown" : (value.toInt() + min.toInt())} $unit',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  String displaySalt(int? saltLevel) {
    if (saltLevel == null) {
      return "Unknown";
    }

    return saltLevel.toString();
  }

  Widget displayStatus(String? status) {
    if (status == null) {
      return Container();
    }

    var widgets = <Widget>[];
    var isOk = status.contains("Ok");

    if (isOk) {
      widgets.add(
        Icon(
          Icons.check_circle_outline,
          color: Colors.green,
          size: 64,
        ),
      );
    } else {
      widgets.add(
        Icon(
          Icons.warning_rounded,
          color: Colors.yellowAccent,
          size: 64,
        ),
      );
    }

    widgets.add(
      SizedBox(
        width: 8,
      ),
    );

    if (isOk) {
      widgets.add(AutoSizeText(
        "All Systems Ok",
        minFontSize: 24,
      ));
    } else {
      widgets.add(
        BlinkingText(
          content: status,
          style: TextStyle(fontSize: 24),
        ),
      );
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: widgets);
  }
}
