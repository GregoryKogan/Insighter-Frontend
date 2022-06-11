import 'dart:convert';
import 'package:mw_insider/api/jwt.dart';
import 'package:mw_insider/configuration/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeoSyncService {
  final JwtService jwt = JwtService();

  Duration timeSince(String timestamp) {
    final DateTime moment = DateTime.parse(timestamp);
    final DateTime now = DateTime.now();
    return now.difference(moment);
  }

  Future<bool> isSyncNecessary() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('lastSync')) return true;
    final String lastSync = prefs.getString('lastSync')!;
    return timeSince(lastSync).compareTo(geoSyncFrequency) > 0;
  }

  Future<void> syncGeoObjects() async {
    final response = await jwt.makeBackendRequest('GET', 'geoObjects/syncUser');
    final data = jsonDecode(response.body);
    String geoObjectsData = jsonEncode(data['GeoObjects']);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('GeoObjects', geoObjectsData);
    await prefs.setString('lastSync', DateTime.now().toIso8601String());
    return;
  }
}
