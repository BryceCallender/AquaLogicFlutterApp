import 'dart:math';
import 'package:aqua_logic_controller/Models/aqualogic_provider.dart';
import 'package:aqua_logic_controller/UI/pool-card.dart';
import 'package:aqua_logic_controller/Models/states.dart';
import 'package:aqua_logic_controller/UI/service-mode.dart';
import 'package:aqua_logic_controller/UI/temperature-card.dart';
import 'package:aqua_logic_controller/helpers/StateHelper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import '../CustomIcons/waterfall_icons.dart';
import 'filter-card.dart';

class PoolControls extends StatefulWidget {
  @override
  _PoolControlsState createState() => _PoolControlsState();
}

class _PoolControlsState extends State<PoolControls> {
  bool isActive(PoolState state) {
    var poolState = context
        .select((AquaLogicProvider provider) => provider.aquaLogic.poolStates);
    return checkState(poolState ?? 0, state);
  }

  bool isFlashing(PoolState state) {
    var flashingState = context.select(
        (AquaLogicProvider provider) => provider.aquaLogic.flashingStates);
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
    checkServiceMode();

    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          createHeader("Temperatures"),
          Flexible(
            flex: 1,
            child: temperatureWidgets(context),
          ),
          ...headerAndDivider("Controls"),
          Flexible(
            flex: 3,
            child: controlWidgets(context),
          )
        ],
      ),
    );
  }

  Widget temperatureWidgets(BuildContext context) {
    var isMetric = context
        .select((AquaLogicProvider provider) => provider.aquaLogic.isMetric);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1)
        },
        children: <TableRow>[
          TableRow(
            children: <Widget>[
              TemperatureCard(
                  display: "Air",
                  temp: context.select((AquaLogicProvider provider) =>
                      provider.aquaLogic.airTemp),
                  isMetric: isMetric ?? false),
              TemperatureCard(
                  display: "Pool",
                  temp: context.select((AquaLogicProvider provider) =>
                      provider.aquaLogic.poolTemp),
                  isMetric: isMetric ?? false),
              TemperatureCard(
                  display: "Spa",
                  temp: context.select((AquaLogicProvider provider) =>
                      provider.aquaLogic.spaTemp),
                  isMetric: isMetric ?? false),
            ],
          ),
        ],
      ),
    );
  }

  Widget controlWidgets(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      crossAxisCount: 2,
      children: <Widget>[
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
          isFlashing: isFlashing(PoolState.FILTER),
        ),
        PoolCard(
          display: "Lights",
          icon: Icons.light_mode_outlined,
          state: PoolState.LIGHTS,
          isEnabled: isActive(PoolState.LIGHTS),
        ),
        PoolCard(
          display: "Waterfall",
          icon: Waterfall.waterfall,
          state: PoolState.AUX_2,
          isEnabled: isActive(PoolState.AUX_2),
        )
      ],
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

  void checkServiceMode() {
    if (StateHelper.checkServiceMode(context)) {
      context.loaderOverlay.show(
          widget: ServiceMode()
      );
    }
  }
}
