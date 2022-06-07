import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mw_insider/api/jwt.dart';
import 'package:mw_insider/configuration/config.dart';
import 'package:mw_insider/state_controllers/state_controller.dart';

class AuthorizationService {
  final stateController = Get.put(StateController());
  JwtService jwt = JwtService();
  final storage = const FlutterSecureStorage();

  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${backendUrl}auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      stateController.setErrorString(jsonDecode(response.body)['msg']);
      return;
    }

    await jwt.setAccessToken(jsonDecode(response.body)['access_token']);
    await jwt.setRefreshToken(jsonDecode(response.body)['refresh_token']);
    await storage.write(key: 'username', value: username);
    await storage.write(key: 'password', value: password);
    Get.offNamed('/');
  }

  Future<void> logout() async {
    await jwt.deleteAllTokens();
    await storage.delete(key: 'username');
    await storage.delete(key: 'password');
    Get.offNamed('/loading');
  }

  Future<void> signUp(String username, String password) async {
    final response = await http.post(
      Uri.parse('${backendUrl}users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      stateController.setErrorString(jsonDecode(response.body)['msg']);
      return;
    }

    await login(username, password);
  }
}
