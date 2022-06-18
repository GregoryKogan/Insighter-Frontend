import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:insighter/api/jwt.dart';
import 'package:insighter/configuration/config.dart';

class GeoSyncService {
  final JwtService jwt = JwtService();
  final box = GetStorage();

  Duration timeSince(String timestamp) {
    final DateTime moment = DateTime.parse(timestamp);
    final DateTime now = DateTime.now();
    return now.difference(moment);
  }

  bool isSyncNecessary() {
    if (!box.hasData('lastSync')) return true;
    final String lastSync = box.read('lastSync')!;
    return timeSince(lastSync).compareTo(geoSyncFrequency) > 0;
  }

  Future<void> syncGeoObjects() async {
    final response = await jwt.makeBackendRequest('GET', 'geoObjects/syncUser');
    final data = jsonDecode(response.body);
    String geoObjectsData = jsonEncode(data['GeoObjects']);
    await box.write('GeoObjects', geoObjectsData);
    await box.write('lastSync', DateTime.now().toIso8601String());
    return;
  }
}
