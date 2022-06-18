import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:insighter/api/geo_objects/exploring_service.dart';
import 'package:insighter/state_controllers/location_controller.dart';

class GeofencingService {
  final exploringService = ExploringService();
  final locationController = Get.put(LocationController());

  void startTracking() async {
    final streamController = StreamController<Position>.broadcast();

    LocationSettings locationSettings = getSettings();
    final geoSub =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      streamController.sink.add(position);
    });

    final str = streamController.stream;
    final sub = str.listen((Position position) {
      print(position);
      locationController.updateLocation(position.latitude, position.longitude);
      exploringService.getNearbyObjects();
      updateAddress();
    });
    locationController.setIsTracking(true);
    locationController.setLocationStreamController(streamController);
    locationController.setLocationStream(str);
    locationController.setGeolocatorStreamSubscription(geoSub);
    locationController.setLocationStreamSubscription(sub);

    Future.delayed(const Duration(seconds: 1), () => fetchLocation());
  }

  void stopTracking() {
    if (locationController.locationStreamSubscription.value != null) {
      locationController.locationStreamSubscription.value!.cancel();
    }
    if (locationController.geolocatorStreamSubscription.value != null) {
      locationController.geolocatorStreamSubscription.value!.cancel();
    }
    locationController.setIsTracking(false);
    locationController.setLocationStream(null);
    locationController.setGeolocatorStreamSubscription(null);
    locationController.setLocationStreamSubscription(null);
  }

  LocationSettings getSettings() {
    late LocationSettings locationSettings;

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 20,
        intervalDuration: const Duration(seconds: 5),
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

    return locationSettings;
  }

  Future<Position?> fetchLocation() async {
    final permission = await askForPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) return null;

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    locationController.updateLocation(position.latitude, position.longitude);
    if (locationController.locationStreamController.value != null) {
      locationController.locationStreamController.value!.sink.add(position);
    }
    await exploringService.getNearbyObjects();
    await updateAddress();

    return position;
  }

  Future<String> updateAddress() async {
    final addresses = await placemarkFromCoordinates(
        locationController.latitude.value, locationController.longitude.value);
    final first = addresses.first;
    String address = '';
    if (first.locality != '') address += '${first.locality}';
    if (first.thoroughfare != '' && address != '') {
      address += ', ${first.thoroughfare}';
    } else if (first.thoroughfare != '') {
      address += '${first.thoroughfare}';
    }
    if (first.subThoroughfare != '' && address != '') {
      address += ' ${first.subThoroughfare}';
    } else if (first.subThoroughfare != '') {
      address += '${first.administrativeArea} ${first.subThoroughfare}';
    }
    if (first.thoroughfare == '' && first.subThoroughfare == '') {
      if (first.street != '') {
        address = first.street!;
      } else {
        address = first.administrativeArea!;
      }
    }
    locationController.setAddress(address);
    return address;
  }

  Future<LocationPermission> askForPermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
    }
    locationController.setLocationPermission(permission);
    return permission;
  }
}
