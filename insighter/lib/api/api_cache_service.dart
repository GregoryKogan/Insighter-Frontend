import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:insighter/configuration/config.dart';

class ApiCacheService {
  final cache = GetStorage('API_CACHE');

  ApiCacheService() {
    for (String key in cache.getKeys()) {
      if (isStale(key)) {
        removeCached(key);
      }
    }
  }

  bool isStale(String key) {
    Map<String, dynamic>? cacheData = cache.read(key);
    if (cacheData == null) return false;
    DateTime timestamp = DateTime.parse(cacheData['timestamp']);
    DateTime now = DateTime.now();
    return (now.difference(timestamp) > apiCacheStalePeriod);
  }

  Map<String, dynamic> encodeResponse(http.Response response) {
    return {
      'body': response.body,
      'statusCode': response.statusCode,
      'headers': response.headers,
    };
  }

  http.Response decodeResponse(Map<String, dynamic> responseData) {
    return http.Response(responseData['body'], responseData['statusCode'],
        headers: Map<String, String>.from(responseData['headers']));
  }

  cacheResponse(
    String endpoint,
    http.Response response,
  ) {
    Map<String, dynamic> cacheData = {
      'response': encodeResponse(response),
      'timestamp': DateTime.now().toIso8601String(),
    };
    cache.write(endpoint, cacheData);
  }

  http.Response? getCached(String endpoint) {
    Map<String, dynamic>? cacheData = cache.read(endpoint);
    if (cacheData == null) return null;
    return decodeResponse(cacheData['response']);
  }

  void removeCached(String endpoint) {
    cache.remove(endpoint);
  }

  void eraseAll() {
    cache.erase();
  }
}
