import 'package:aqua_logic_controller/Models/states.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({Key? key}) : super(key: key);

  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  late TextEditingController _hostController;
  late TextEditingController _portController;
  late String _waterfallState = PoolState.NONE.name;

  @override
  void initState() {
    super.initState();
    _hostController = TextEditingController();
    _portController = TextEditingController();
    readConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: _hostController,
                decoration: InputDecoration(
                  labelText: "Host",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: _portController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Port",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DropdownButton<String>(
                hint: Text("Waterfall"),
                isExpanded: true,
                items: PoolState.values
                    .map(
                      (ps) => DropdownMenuItem<String>(
                        value: ps.name,
                        child:
                            // ? Container(
                            //     child: Text(
                            //     ps.name,
                            //     style: TextStyle(color: Colors.blueAccent),
                            //   ))
                            // :
                          Text(ps.name),
                      ),
                    )
                    .toList(),
                value: _waterfallState,
                onChanged: (String? value) {
                  setState(() {
                    _waterfallState = value!;
                  });
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveConfig,
                child: const Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void readConfig() async {
    var prefs = await SharedPreferences.getInstance();

    setState(() {
      _hostController.text = prefs.getString("host") ?? "";
      _portController.text = prefs.getString("port") ?? "";

      var waterFallState = prefs.getString("waterfall") ?? "NONE";
      _waterfallState =
          PoolState.values.firstWhere((ps) => ps.name == waterFallState).name;
    });
  }

  void saveConfig() async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString("host", _hostController.text);
    prefs.setString("port", _portController.text);
    prefs.setString("waterfall", _waterfallState);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Saved config changes!"),
    ));
  }
}
