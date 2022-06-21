import 'dart:math';

import 'package:aqua_logic_controller/Models/states.dart';
import 'package:aqua_logic_controller/UI/spinning-icon.dart';
import 'package:aqua_logic_controller/helpers/ApiBaseHelper.dart';
import 'package:aqua_logic_controller/helpers/api-constants.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FilterCard extends StatefulWidget {
  final String display;
  final IconData icon;
  final bool isEnabled;
  final bool isFlashing;

  const FilterCard(
      {Key? key,
      required this.display,
      required this.icon,
      required this.isEnabled,
      required this.isFlashing})
      : super(key: key);

  @override
  State<FilterCard> createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color:
            widget.isEnabled ? Color(0xFF2845f9) : Theme.of(context).cardColor,
        child: InkWell(
          onTap: () => sendState(),
          child: Container(
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
                        child: isFilterOn()
                            ? SpinningIcon(
                                icon: widget.icon,
                                duration: durationFromState())
                            : Icon(widget.icon),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.display,
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendState() async {
    var filterDisplayText = "";

    var flashing = widget.isFlashing;
    var enabled = widget.isEnabled;

    if (enabled && flashing) {
      filterDisplayText = "Turning Filter Off";
    } else if (enabled && !flashing) {
      filterDisplayText = "Turning Filter Low Speed";
    } else {
      filterDisplayText = "Turning Filter High Speed";
    }

    ApiBaseHelper.put(ApiConstants.setStateEndpoint, { 'state': pow(2, PoolState.FILTER.index - 1) });

    context.loaderOverlay.show();

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content:
    //         Text(filterDisplayText),
    //   ),
    // );
  }

  bool isFilterOn() {
    return widget.isFlashing || widget.isEnabled;
  }

  Duration durationFromState() {
    if (!widget.isFlashing) {
      return Duration(seconds: 1);
    }

    return Duration(seconds: 4);
  }
}
