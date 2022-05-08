import 'dart:io';

import 'package:aqua_logic_controller/Models/aqualogic_provider.dart';
import 'package:aqua_logic_controller/UI/pool-dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';

class ConnectPage extends StatefulWidget {

  ConnectPage({Key? key}) : super(key: key);

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  TextEditingController hostController = new TextEditingController();
  TextEditingController portController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: TextField(
                controller: hostController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Host", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: portController,
                keyboardType: TextInputType.number,
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
    );
  }

  void connectToPoolServer(context) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    var host = hostController.text;
    var port = portController.text;
    var bypass = true;

    // var uri = Uri.https("$host:5001", "/health");
    // print(uri);
    //
    // final http = new IOClient(client);
    //
    // var response;
    // if (host != "0.0.0.0") {
    //   bypass = false;
    //   response = await http.get(uri);
    // }

    var aquaProvider = Provider.of<AquaLogicProvider>(context, listen: false);
    await aquaProvider.subscribe("https://localhost:5001");

    // if (bypass || response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PoolDashboard(),
        ),
      );
    // }
  }
}
