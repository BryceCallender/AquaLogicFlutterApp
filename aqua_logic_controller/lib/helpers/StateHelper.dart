import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/aqualogic_provider.dart';
import '../Models/states.dart';

class StateHelper {
  static bool checkState(int state, PoolState poolState) {
    var stateValue = pow(2, poolState.index - 1) as int;
    return (state & stateValue) == stateValue;
  }

  static bool checkServiceMode(BuildContext context) {
    bool serviceMode = context.select((AquaLogicProvider value) =>
        checkState(value.aquaLogic.poolStates ?? 0, PoolState.SERVICE));

    return serviceMode;
  }
}