import 'dart:io';

import 'package:aqua_logic_controller/Models/aqualogic_provider.dart';
import 'package:aqua_logic_controller/UI/pool-dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectPage extends StatefulWidget {

  ConnectPage({Key? key}) : super(key: key);

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  final _formKey = GlobalKey<FormState>();
  var _hostController = TextEditingController();
  var _portController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: RichText(
                  text: TextSpan(
                      text: "Connect to the Pool server",
                      style: TextStyle(fontSize: 28)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _hostController,
                  keyboardType: TextInputType.text,
                  validator: formValidator,
                  decoration: InputDecoration(
                      labelText: "Host", border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _portController,
                  keyboardType: TextInputType.number,
                  validator: formValidator,
                  decoration: InputDecoration(
                      labelText: "Port", border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text("Connect"),
                    onPressed: () async => connectToPoolServer(context),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void connectToPoolServer(context) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

     if (_formKey.currentState!.validate()) {
       var prefs = await SharedPreferences.getInstance();
       prefs.setString("host", _hostController.text);
       prefs.setString("port", _portController.text);

       Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PoolDashboard(),
        ),
      );
    }
  }

  String? formValidator (String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a value";
    }
    return null;
  }
}
