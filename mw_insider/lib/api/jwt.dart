import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;
import 'package:mw_insider/configuration/config.dart';

class JwtService {
  final storage = const FlutterSecureStorage();

  Future<bool> isLoggedIn() async {
    String? accessToken = await storage.read(key: 'access');
    String? refreshToken = await storage.read(key: 'refresh');
    return (accessToken != null && refreshToken != null);
  }

  Future<bool> isRefreshable() async {
    String? refreshToken = await storage.read(key: 'refresh');
    if (refreshToken == null) return false;
    DateTime? expiryDate = Jwt.getExpiryDate(refreshToken);
    if (expiryDate == null) return false;
    DateTime now = DateTime.now();

    return (now.isBefore(expiryDate) &&
        expiryDate.difference(now).inHours > 24);
  }

  Future<bool> getNewTokens() async {
    final String? username = await storage.read(key: 'username');
    final String? password = await storage.read(key: 'password');
    if (password == null || username == null) return false;

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

    if (response.statusCode != 200) return false;

    await setAccessToken(jsonDecode(response.body)['access_token']);
    await setRefreshToken(jsonDecode(response.body)['refresh_token']);
    return true;
  }

  Future<String> getAccessToken() async {
    String? accessToken = await storage.read(key: 'access');
    if (accessToken == null) throw Exception('Access token is null');
    return accessToken;
  }

  Future<void> setAccessToken(String accessToken) async {
    await storage.write(key: 'access', value: accessToken);
  }

  Future<void> setRefreshToken(String refreshToken) async {
    await storage.write(key: 'refresh', value: refreshToken);
  }

  Future<void> deleteAllTokens() async {
    await storage.delete(key: 'access');
    await storage.delete(key: 'refresh');
  }
}
