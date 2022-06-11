import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mw_insider/configuration/config.dart';
import 'package:mw_insider/state_controllers/location_controller.dart';

class ExploringService {
  final locationController = Get.put(LocationController());
  final box = GetStorage();

  dynamic getAllGeoObjects() {
    final String? geoObjectsData = box.read('GeoObjects');
    if (geoObjectsData == null) return [];
    return jsonDecode(geoObjectsData);
  }

  Future<void> getNearbyObjects() async {
    double myLat = locationController.latitude.value;
    double myLon = locationController.longitude.value;
    final geoObjects = getAllGeoObjects();
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
