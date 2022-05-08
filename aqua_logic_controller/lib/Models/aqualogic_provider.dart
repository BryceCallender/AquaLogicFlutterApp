import 'dart:io';

import 'package:aqua_logic_controller/Models/aqualogic.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:signalr_netcore/signalr_client.dart';

class AquaLogicProvider extends ChangeNotifier {
  AquaLogic _aquaLogic = AquaLogic();

  late String _serverUrl;
  late HubConnection _hubConnection;

  AquaLogic get aquaLogic => _aquaLogic;

  Future subscribe(String serverUrl) async {
    _serverUrl = serverUrl + "/aqualogichub";
    print(_serverUrl);

    final httpConnectionOptions = new HttpConnectionOptions(
        httpClient: WebSupportingHttpClient(null,
            httpClientCreateCallback: _httpClientCreateCallback));

    _hubConnection = HubConnectionBuilder()
        .withUrl(_serverUrl, options: httpConnectionOptions)
        .withAutomaticReconnect(
            retryDelays: [2000, 5000, 10000, 20000]).build();

    _hubConnection.onclose(({error}) => print("Connection Closed"));
    _hubConnection.on("UpdateDisplay", _handleUpdateDisplay);

    await _hubConnection.start();
    print('connected');
  }

  void _handleUpdateDisplay(List<Object>? args) {
    if (args != null) {
      _aquaLogic = AquaLogic.fromJson(args[0] as Map<String, dynamic>);

      notifyListeners();
    }
  }

  void _httpClientCreateCallback(Client httpClient) {
    HttpOverrides.global = HttpOverrideCertificateVerificationInDev();
  }
}

class HttpOverrideCertificateVerificationInDev extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

