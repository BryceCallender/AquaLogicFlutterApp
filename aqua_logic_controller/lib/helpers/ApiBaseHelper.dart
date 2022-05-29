import 'dart:convert';
import 'package:aqua_logic_controller/helpers/api-constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ApiBaseHelper {

  static Future<dynamic> get(String endpoint) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + endpoint);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> post(String endpoint, dynamic body) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + endpoint);
      var response = await http.post(url, body: body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
        print(e);
    }
  }
}