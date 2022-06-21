import 'dart:convert';
import 'dart:math';

import 'package:aqua_logic_controller/Models/aqualogic_provider.dart';
import 'package:aqua_logic_controller/Models/display.dart';
import 'package:aqua_logic_controller/UI/blinking-text.dart';
import 'package:aqua_logic_controller/helpers/ApiBaseHelper.dart';
import 'package:aqua_logic_controller/helpers/api-constants.dart';
import 'package:flutter/material.dart';
import 'package:aqua_logic_controller/Models/key.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../helpers/StateHelper.dart';

class Emulator extends StatelessWidget {
  const Emulator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool serviceMode = StateHelper.checkServiceMode(context);
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 5,
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
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [emulatorButton(ControllerKeyEvent.PLUS, '+', serviceMode)],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        emulatorButton(ControllerKeyEvent.LEFT, '<', serviceMode),
                        emulatorButton(ControllerKeyEvent.MENU, 'Menu', serviceMode),
                        emulatorButton(ControllerKeyEvent.RIGHT, '>', serviceMode)
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [emulatorButton(ControllerKeyEvent.MINUS, '-', serviceMode)],
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

  Widget emulatorButton(ControllerKeyEvent key, String display, bool serviceMode) {
    return ElevatedButton(
      onPressed: !serviceMode ? () async => await emulatorButtonPressed(key) : null,
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
    var formattedDisplay = display?.displaySections ?? [DisplaySection()];

    List<Widget> textWidgets = [];
    List<Widget> linesOfText = [];

    var currentRow = 1;
    for (var section in formattedDisplay) {
      if (section.displayRow != currentRow) {
        textWidgets.add(
          Row(
            children: linesOfText,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        );
        linesOfText = [];
        currentRow = section.displayRow ?? ++currentRow;
      }

      var content = section.content ?? '';
      content = content.replaceAll('_', '°');

      var textStyle =
          TextStyle(fontSize: 42 - (12 * textWidgets.length).toDouble());

      if (section.blinking ?? false) {
        linesOfText.add(
          BlinkingText(
            content: content,
            style: textStyle,
          ),
        );
      } else {
        linesOfText.add(
          Text(
            content,
            style: textStyle,
          ),
        );
      }

      linesOfText.add(SizedBox(width: 8,));
    }

    textWidgets.add(
      Row(
        children: linesOfText,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );

    return textWidgets;
  }

  Future emulatorButtonPressed(ControllerKeyEvent key) async {
    ApiBaseHelper.put(ApiConstants.sendKeyEndpoint, {'key': pow(2, key.index - 1)});
  }
}
