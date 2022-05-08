import 'dart:convert';
import 'dart:math';

import 'package:aqua_logic_controller/Models/aqualogic_provider.dart';
import 'package:flutter/material.dart';
import 'package:aqua_logic_controller/Models/key.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Emulator extends StatelessWidget {
  const Emulator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: controllerText(context),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [emulatorButton(ControllerKeyEvent.PLUS, '+')],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        emulatorButton(ControllerKeyEvent.LEFT, '<'),
                        emulatorButton(ControllerKeyEvent.MENU, 'Menu'),
                        emulatorButton(ControllerKeyEvent.RIGHT, '>')
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [emulatorButton(ControllerKeyEvent.MINUS, '-')],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget emulatorButton(ControllerKeyEvent key, String display) {
    return ElevatedButton(
      onPressed: () async => await emulatorButtonPressed(key),
      child: Text(
        display,
        style: TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(100, 50) // put the width and height you want
          ),
    );
  }

  List<Widget> controllerText(BuildContext context) {
    var display = context.watch<AquaLogicProvider>().aquaLogic.display;
    var formattedDisplay = display?.displaySections ?? <String>['Display Error'];

    var textWidgets = <Widget>[];

    for (var section in formattedDisplay) {
      textWidgets.add(
        RichText(
          text: TextSpan(
            text: '',
            style:
                TextStyle(fontSize: 42 - (12 * textWidgets.length).toDouble()),
          ),
        ),
      );
    }

    return textWidgets;
  }

  Future emulatorButtonPressed(ControllerKeyEvent key) async {
    var uri = Uri.http("localhost:5002", "/api/aqualogic/key");
    await http.post(uri, body: jsonEncode({'key': pow(2, key.index - 1)}));
  }
}
