import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:insighter/geolocation/geofencing.dart';
import 'package:insighter/state_controllers/location_controller.dart';
import 'package:insighter/theming/themes.dart';
import 'package:insighter/widgets/main_page/give_permission_button.dart';

class TrackingButton extends StatelessWidget {
  TrackingButton({Key? key}) : super(key: key);

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
      () => ElevatedButton(
          onPressed: _onPressed,
          style: ElevatedButton.styleFrom(
              primary: context.theme.extension<Palette>()!.magenta,
              shape: const StadiumBorder(),
              elevation: 10,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0)),
          child: Text(
              locationController.isTracking.value
                  ? 'Stop tracking'
                  : 'Start tracking',
              style: TextStyle(
                  color: context.theme.extension<Palette>()!.background))),
    );
  }
}
