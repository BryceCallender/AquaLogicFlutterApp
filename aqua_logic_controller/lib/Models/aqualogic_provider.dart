import 'dart:io';
import 'dart:math';

import 'package:aqua_logic_controller/Models/aqualogic.dart';
import 'package:aqua_logic_controller/Models/states.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../helpers/api-constants.dart';

class AquaLogicProvider extends ChangeNotifier {
  AquaLogic _aquaLogic = AquaLogic();

  late String _serverUrl;
  late HubConnection _hubConnection;
  late bool _connected = false;

  AquaLogic get aquaLogic => _aquaLogic;
  bool get connected => _connected;
  bool get disabled => checkState(PoolState.SERVICE);

  Future<void> subscribe() async {
    _serverUrl = ApiConstants.baseUrl + ApiConstants.aqualogicHubEndpoint;
    print(_serverUrl);

    final httpConnectionOptions = new HttpConnectionOptions(
        httpClient: WebSupportingHttpClient(null,
            httpClientCreateCallback: _httpClientCreateCallback));

    _hubConnection = HubConnectionBuilder()
        .withUrl(_serverUrl, options: httpConnectionOptions)
        .withAutomaticReconnect(
            retryDelays: [2000, 5000, 10000, 20000]).build();


    _hubConnection.on("UpdateDisplay", _handleUpdateDisplay);

    // Event Listeners
    _hubConnection.onclose(({error}) {
      _connected = false;
      print("Connection Closed");
      notifyListeners();
    });

    _hubConnection.onreconnecting(({error}) {
      _connected = false;
      print("Reconnecting...");
      notifyListeners();
    });

    _hubConnection.onreconnected(({connectionId}) {
      _connected = true;
      print("Reconnected.");
      notifyListeners();
    }
  );

    if (_hubConnection.state != HubConnectionState.Connected) {
      int maxAttempts = 10;
      int attempts = 0;
      while (!_connected && attempts < maxAttempts) {
        try {
          ++attempts;
          await _hubConnection.start();
          _connected = true;
          print('connected');
          notifyListeners();
        } catch(e) {
          
        }
      }
    }
  }

  bool checkState(PoolState poolState) {
    var stateValue = pow(2, poolState.index - 1) as int;
    return ((_aquaLogic.poolStates ?? 0) & stateValue) == stateValue;
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

