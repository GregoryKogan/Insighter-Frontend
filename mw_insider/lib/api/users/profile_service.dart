import 'dart:convert';
import 'package:mw_insider/api/jwt.dart';

class ProfileService {
  JwtService jwt = JwtService();

  Future<Map<String, dynamic>> getProfile() async {
    return jsonDecode((await jwt.makeBackendRequest('GET', 'users/me',
            jwtRequired: true, cache: true))
        .body);
  }
}
