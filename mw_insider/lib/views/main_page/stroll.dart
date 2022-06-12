import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mw_insider/geolocation/geofencing.dart';
import 'package:mw_insider/state_controllers/location_controller.dart';
import 'package:mw_insider/widgets/main_page/give_permission_button.dart';

class Stroll extends StatelessWidget {
  Stroll({Key? key}) : super(key: key);

  final locationController = Get.put(LocationController());
  final geofencingService = GeofencingService();

  void _onPressed() async {
    if (locationController.isTracking.value) {
      geofencingService.stopTracking();
    } else {
      final permission = locationController.locationPermission.value;
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        Get.defaultDialog(
          title: 'Geolocation is prohibited',
          content: Column(
            children: [
              const Text(
                  'This app needs to track your location in order to notify you about sights nearby'),
              GivePermissionButton(),
            ],
          ),
        );
        return;
      }
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
