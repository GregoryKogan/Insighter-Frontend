import 'dart:convert';
import 'package:insighter/api/jwt.dart';

class ObjectDataService {
  JwtService jwt = JwtService();

  Future<Map<String, dynamic>> getObjectData(int id) async {
    return jsonDecode((await jwt.makeBackendRequest('GET', 'geoObjects/$id',
            jwtRequired: false, cache: true))
        .body);
  }
}
