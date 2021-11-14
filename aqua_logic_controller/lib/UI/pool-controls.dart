import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:aqua_logic_controller/Models/aqualogic.dart';
import 'package:aqua_logic_controller/UI/error-page.dart';
import 'package:aqua_logic_controller/UI/pool-state-card.dart';
import 'package:aqua_logic_controller/Models/states.dart';
import 'package:aqua_logic_controller/UI/temperature-card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../CustomIcons/waterfall_icons.dart';

class PoolControls extends StatefulWidget {
  @override
  _PoolControlsState createState() => _PoolControlsState();
}

class _PoolControlsState extends State<PoolControls> {
  AquaLogic? aquaLogic;

  Future<AquaLogic?> getPoolData() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    final uri = Uri.https("localhost:5002", "/api/aqualogic");

    var request = await client.getUrl(uri);
    var response = await request.close();

    var body = await response.transform(utf8.decoder).join();

    if (response.statusCode == 200) {
      aquaLogic = AquaLogic.fromJson(json.decode(body));
    }

    return aquaLogic;
  }

  bool isStateActive(PoolState state) {
    var stateValue = pow(2, state.index - 1) as int;
    return ((aquaLogic?.poolStates ?? 0) & stateValue) == stateValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getPoolData(),
          builder: (context, AsyncSnapshot<AquaLogic?> snapshot) {
            if (snapshot.hasError) {
              return ErrorPage(error: snapshot.error);
            }

            if (snapshot.connectionState == ConnectionState.none &&
                !snapshot.hasData) {
              return Container(
                child: Center(
                  child: Text("No data..."),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return Column(children: [
                Padding(padding: EdgeInsets.only(top: 8.0)),
                createHeader("Temperatures"),
                temperatureWidgets(),
                ...headerAndDivider("Controls"),
                controlWidgets(),
                otherWidgets(),
                ...headerAndDivider("Spa Controls")
              ]);
            }

            return Container(
              child: Center(
                child: Text("No data..."),
              ),
            );
          }),
    );
  }

  Widget controlWidgets() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PoolStateCard(
              display: "Pool",
              icon: Icons.pool,
              state: PoolState.POOL,
              isEnabled: isStateActive(PoolState.POOL)),
          PoolStateCard(
              display: "Spa",
              icon: Icons.hot_tub,
              state: PoolState.SPA,
              isEnabled: isStateActive(PoolState.SPA)),
          PoolStateCard(
              display: "Filter",
              icon: FontAwesomeIcons.fan,
              state: PoolState.FILTER,
              isEnabled: isStateActive(PoolState.FILTER))
        ],
      ),
    );
  }

  Widget temperatureWidgets() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TemperatureCard(
              display: "Air",
              temp: aquaLogic?.airTemp,
              isMetric: aquaLogic?.isMetric ?? false),
          TemperatureCard(
              display: "Pool",
              temp: aquaLogic?.poolTemp,
              isMetric: aquaLogic?.isMetric ?? false),
          TemperatureCard(
              display: "Spa",
              temp: aquaLogic?.spaTemp,
              isMetric: aquaLogic?.isMetric ?? false)
        ],
      ),
    );
  }

  Widget otherWidgets() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PoolStateCard(
              display: "Lights",
              icon: Icons.light_mode_outlined,
              state: PoolState.LIGHTS,
              isEnabled: isStateActive(PoolState.LIGHTS)),
          PoolStateCard(
              display: "Waterfall",
              icon: Waterfall.waterfall,
              state: PoolState.AUX_2,
              isEnabled: isStateActive(PoolState.AUX_2))
        ],
      ),
    );
  }

  Widget createHeader(String header) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: header,
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  List<Widget> headerAndDivider(String header) {
    return [Divider(thickness: 3), createHeader(header)];
  }
}
