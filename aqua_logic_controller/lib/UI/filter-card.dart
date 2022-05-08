import 'package:aqua_logic_controller/UI/spinning-icon.dart';
import 'package:flutter/material.dart';

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
                isFilterOn() ? SpinningIcon(icon: widget.icon, duration: durationFromState()): Icon(widget.icon, size: 64),
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

  bool isFilterOn() {
    return widget.isFlashing || widget.isEnabled;
  }

  Duration durationFromState() {
    if (widget.isFlashing) {
      return Duration(seconds: 1);
    }

    return Duration(seconds: 4);
  }
}
