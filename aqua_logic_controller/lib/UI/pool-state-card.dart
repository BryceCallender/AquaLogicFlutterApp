import 'package:aqua_logic_controller/Models/states.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class PoolStateCard extends StatefulWidget {
  final String display;
  final IconData icon;
  final PoolState state;
  final bool isEnabled;

  const PoolStateCard(
      {Key? key,
      required this.display,
      required this.icon,
      required this.state,
      required this.isEnabled})
      : super(key: key);

  @override
  _PoolStateCardState createState() => _PoolStateCardState();
}

class _PoolStateCardState extends State<PoolStateCard> {
  bool isActive = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isActive = widget.isEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: 125,
      child: Card(
        color: widget.isEnabled ? Colors.deepPurple : Theme.of(context).cardColor,
        child: InkWell(
          splashColor: Colors.deepPurple,
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
    setState(() {
      isActive = !isActive;
    });
    // print(pow(2, widget.state.index - 1));
    // var uri = Uri.http("localhost:5002", "/api/aqualogic/setstate");
    // final result = await http.post(uri,
    //     body: { 'state': pow(2,widget.state.index) } //2^i since we do not have bitflag enums in dart
    // );
  }
}
