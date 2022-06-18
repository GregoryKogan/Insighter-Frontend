import 'dart:convert';
import 'package:insighter/configuration/config.dart';
import 'package:http/http.dart' as http;

class PingService {
  Future<bool> ping() async {
    final response = await http
        .get(Uri.parse('${backendUrl}ping'))
        .catchError((err) => http.Response('$err', 408))
        .timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('Error', 408);
    });

    return (response.statusCode == 200 &&
        jsonDecode(response.body)['message'] == 'pong');
  }
}
