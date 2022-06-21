import 'dart:convert';
import 'package:aqua_logic_controller/helpers/api-constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ApiBaseHelper {

  static Future<dynamic> get(String endpoint, [Map<String, String>? parameters]) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + endpoint).replace(queryParameters: parameters);
      print(url);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> put(String endpoint, dynamic body) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + endpoint);
      var response = await http.put(url, body: jsonEncode(body));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}