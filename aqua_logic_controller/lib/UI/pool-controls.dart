import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:aqua_logic_controller/Models/aqualogic.dart';
import 'package:aqua_logic_controller/Models/aqualogic_provider.dart';
import 'package:aqua_logic_controller/UI/error-page.dart';
import 'package:aqua_logic_controller/UI/pool-card.dart';
import 'package:aqua_logic_controller/Models/states.dart';
import 'package:aqua_logic_controller/UI/temperature-card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import '../CustomIcons/waterfall_icons.dart';
import 'filter-card.dart';

class PoolControls extends StatefulWidget {
  @override
  _PoolControlsState createState() => _PoolControlsState();
}

class _PoolControlsState extends State<PoolControls> {

  bool isActive(PoolState state) {
    var poolState = context.watch<AquaLogicProvider>().aquaLogic.poolStates;
    return checkState(poolState ?? 0, state);
  }

  bool isFlashing(PoolState state) {
    var flashingState = context.watch<AquaLogicProvider>().aquaLogic.flashingStates;
    return checkState(flashingState ?? 0, state);
  }

  bool checkState(int state, PoolState poolState) {
    var stateValue = pow(2, poolState.index - 1) as int;
    return (state & stateValue) == stateValue;
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 8.0)),
          createHeader("Temperatures"),
          temperatureWidgets(context),
          ...headerAndDivider("Controls"),
          controlWidgets(context),
          otherWidgets(context)
        ],
      ),
    );
  }

  Widget temperatureWidgets(BuildContext context) {
    var isMetric = context.watch<AquaLogicProvider>().aquaLogic.isMetric;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TemperatureCard(
              display: "Air",
              temp: context.watch<AquaLogicProvider>().aquaLogic.airTemp,
              isMetric: isMetric ?? false),
          TemperatureCard(
              display: "Pool",
              temp: context.watch<AquaLogicProvider>().aquaLogic.poolTemp,
              isMetric: isMetric ?? false),
          TemperatureCard(
              display: "Spa",
              temp: context.watch<AquaLogicProvider>().aquaLogic.spaTemp,
              isMetric: isMetric ?? false),
        ],
      ),
    );
  }

  Widget controlWidgets(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PoolCard(
            display: "Pool",
            icon: Icons.pool,
            state: PoolState.POOL,
            isEnabled: isActive(PoolState.POOL),
          ),
          PoolCard(
            display: "Spa",
            icon: Icons.hot_tub,
            state: PoolState.SPA,
            isEnabled: isActive(PoolState.SPA),
          ),
          FilterCard(
            display: "Filter",
            icon: FontAwesomeIcons.fan,
            isEnabled: isActive(PoolState.FILTER),
            isFlashing: isActive(PoolState.FILTER_LOW_SPEED),
          )
          // PoolCard(
          //     display: "Filter",
          //     icon: FontAwesomeIcons.fan,
          //     state,
          //     isEnabled: isActive(PoolState.FILTER),
          //     isFlashing: isFlashing(PoolState.FILTER_LOW_SPEED),
          // )
        ],
      ),
    );
  }

  Widget otherWidgets(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PoolCard(
              display: "Lights",
              icon: Icons.light_mode_outlined,
              state: PoolState.LIGHTS,
              isEnabled: isActive(PoolState.LIGHTS)),
          PoolCard(
              display: "Waterfall",
              icon: Waterfall.waterfall,
              state: PoolState.AUX_2,
              isEnabled: isActive(PoolState.AUX_2))
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
