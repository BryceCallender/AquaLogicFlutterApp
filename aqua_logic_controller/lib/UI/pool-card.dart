import 'package:aqua_logic_controller/Models/states.dart';
import 'package:aqua_logic_controller/UI/spinning-icon.dart';
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
      height: 120,
      width: 120,
      child: Card(
        color: widget.isEnabled ? Colors.blue : Theme.of(context).cardColor,
        child: InkWell(
          onTap: () => sendState(),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon, size: 64),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(widget.display, style: TextStyle(fontSize: 16)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendState() async {
    // var uri = Uri.http("localhost:5002", "/api/aqualogic/setstate");
    // final result = await http.post(uri,
    //     body: { 'state': pow(2, state.index) } //2^i since we do not have bitflag enums in dart
    // );
  }
}
