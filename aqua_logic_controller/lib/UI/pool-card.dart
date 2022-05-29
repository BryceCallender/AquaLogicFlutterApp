import 'package:aqua_logic_controller/Models/states.dart';
import 'package:aqua_logic_controller/UI/spinning-icon.dart';
import 'package:aqua_logic_controller/helpers/ApiBaseHelper.dart';
import 'package:aqua_logic_controller/helpers/api-constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class PoolCard extends StatefulWidget {
  final String display;
  final IconData icon;
  final PoolState state;
  final bool isEnabled;

  const PoolCard(
      {Key? key,
      required this.display,
      required this.icon,
      required this.state,
      required this.isEnabled})
      : super(key: key);

  @override
  _PoolCardState createState() => _PoolCardState();
}

class _PoolCardState extends State<PoolCard> {
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
                        child: new Icon(widget.icon),
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
    ApiBaseHelper.post(ApiConstants.setStateEndpoint, { 'state': pow(2, widget.state.index - 1) });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "Turning ${widget.display} ${widget.isEnabled ? "Off" : "On"}"),
      ),
    );
  }
}
