import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mw_insider/api/geo_objects/exploring_service.dart';
import 'package:mw_insider/state_controllers/location_controller.dart';

class GeofencingService {
  final exploringService = ExploringService();
  final locationController = Get.put(LocationController());

  void startTracking() async {
    LocationSettings locationSettings = getSettings();
    final sub = Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      locationController.updateLocation(position.latitude, position.longitude);
      exploringService.getNearbyObjects();
    });
    locationController.setIsTracking(true);
    locationController.setLocationStreamSubscription(sub);
  }

  void stopTracking() {
    if (locationController.locationStreamSubscription.value != null) {
      locationController.locationStreamSubscription.value!.cancel();
    }
    locationController.setIsTracking(false);
    locationController.setLocationStreamSubscription(null);
  }

  LocationSettings getSettings() {
    late LocationSettings locationSettings;

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 20,
        intervalDuration: const Duration(seconds: 1),
        forceLocationManager: true,
        foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationTitle: 'MW Insider is tracking your location',
            notificationText: 'App is running in background',
            enableWakeLock: true),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.best,
        activityType: ActivityType.other,
        distanceFilter: 20,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: true,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 20,
      );
    }

    Geolocator.requestPermission();

    return locationSettings;
  }

  Future<Position> fetchLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    locationController.updateLocation(position.latitude, position.longitude);
    await exploringService.getNearbyObjects();

    return position;
  }
}
