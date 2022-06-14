import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final nearbyObjects = <Map<String, dynamic>>[].obs;
  final isTracking = false.obs;
  final locationStreamSubscription = Rx<StreamSubscription<Position>?>(null);
  final address = ''.obs;
  final locationPermission = Rx<LocationPermission?>(null);

  updateLocation(double lat, double lon) {
    latitude(lat);
    longitude(lon);
  }

  updateNearbyObjects(List<Map<String, dynamic>> geoObjects) {
    nearbyObjects(geoObjects);
  }

  setIsTracking(bool val) {
    isTracking(val);
  }

  setLocationStreamSubscription(StreamSubscription<Position>? sub) {
    locationStreamSubscription(sub);
  }

  setAddress(String addr) {
    address(addr);
  }

  setLocationPermission(LocationPermission permission) {
    locationPermission(permission);
  }
}
