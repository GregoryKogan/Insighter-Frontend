import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/geolocation/geofencing.dart';
import 'package:mw_insider/state_controllers/location_controller.dart';

class Stroll extends StatelessWidget {
  Stroll({Key? key}) : super(key: key);

  final locationController = Get.put(LocationController());
  final geofencingService = GeofencingService();

  void _onPressed() {
    if (locationController.isTracking.value) {
      geofencingService.stopTracking();
    } else {
      geofencingService.startTracking();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Center(
            child: TextButton(
                onPressed: _onPressed,
                child: Text(locationController.isTracking.value
                    ? 'Turn OFF tracking'
                    : 'Turn ON tracking'))),
      ),
    );
  }
}
