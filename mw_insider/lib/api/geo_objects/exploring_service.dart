import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mw_insider/configuration/config.dart';
import 'package:mw_insider/state_controllers/location_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExploringService {
  final locationController = Get.put(LocationController());

  Future<dynamic> getAllGeoObjects() async {
    final prefs = await SharedPreferences.getInstance();
    final String? geoObjectsData = prefs.getString('GeoObjects');
    if (geoObjectsData == null) return [];
    return jsonDecode(geoObjectsData);
  }

  Future<void> getNearbyObjects() async {
    double myLat = locationController.latitude.value;
    double myLon = locationController.longitude.value;
    final geoObjects = await getAllGeoObjects();
    List<int> nearbyObjects = [];
    for (final geoObject in geoObjects) {
      final double distance = Geolocator.distanceBetween(
          geoObject['lat'], geoObject['lon'], myLat, myLon);
      if (distance < nearbyObjectsRadius) {
        nearbyObjects.add(geoObject['id']);
      }
    }
    locationController.updateNearbyObjects(nearbyObjects);
    return;
  }
}
