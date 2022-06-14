import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;
import 'package:mw_insider/api/api_cache_service.dart';
import 'package:mw_insider/configuration/config.dart';

class JwtService {
  final storage = const FlutterSecureStorage();
  final apiCacheService = ApiCacheService();

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

  Future<void> refreshAccessToken() async {
    final refreshToken = await getRefreshToken();

    final response = await http
        .post(Uri.parse('${backendUrl}auth/refresh'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $refreshToken',
    });

    if (response.statusCode != 200) return;
    await setAccessToken(jsonDecode(response.body)['access_token']);
  }

  Future<http.Response> makeBackendRequestAttempt(
      String requestType, String endpoint,
      {Map<String, dynamic>? body, bool? jwtRequired}) async {
    var accessToken = '';
    if (jwtRequired != null && jwtRequired) {
      accessToken = await getAccessToken();
    }

    if (requestType == 'GET') {
      return await http
          .get(Uri.parse('$backendUrl$endpoint'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      });
    } else if (requestType == 'POST') {
      return await http.post(
        Uri.parse('$backendUrl$endpoint'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(body),
      );
    } else {
      return http.Response('Method Not Allowed', 405);
    }
  }

  Future<http.Response> makeBackendRequest(String requestType, String endpoint,
      {Map<String, dynamic>? body,
      bool? jwtRequired,
      bool cache = false}) async {
    if (cache) {
      http.Response? cached = apiCacheService.getCached(endpoint);
      if (cached != null) return cached;
    }

    http.Response response = await makeBackendRequestAttempt(
        requestType, endpoint,
        body: body, jwtRequired: jwtRequired);

    if (response.statusCode == 401 &&
        jsonDecode(response.body)['msg'] == 'Token has expired') {
      await refreshAccessToken();
      response = await makeBackendRequestAttempt(requestType, endpoint,
          body: body, jwtRequired: jwtRequired);
    }

    if (cache) apiCacheService.cacheResponse(endpoint, response);

    return response;
  }

  Future<String> getAccessToken() async {
    String? accessToken = await storage.read(key: 'access');
    if (accessToken == null) throw Exception('Access token is null');
    return accessToken;
  }

  Future<String> getRefreshToken() async {
    String? refreshToken = await storage.read(key: 'refresh');
    if (refreshToken == null) throw Exception('Refresh token is null');
    return refreshToken;
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
