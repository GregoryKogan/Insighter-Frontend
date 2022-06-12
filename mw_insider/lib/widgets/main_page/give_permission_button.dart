import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mw_insider/geolocation/geofencing.dart';
import 'package:mw_insider/state_controllers/location_controller.dart';
import 'package:mw_insider/theming/themes.dart';

class GivePermissionButton extends StatelessWidget {
  GivePermissionButton({Key? key}) : super(key: key);

  final geofencingService = GeofencingService();
  final locationController = Get.put(LocationController());

  void _givePermissions() async {
    await Geolocator.openAppSettings();
    final permission = await Geolocator.checkPermission();

    locationController.setLocationPermission(permission);

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      await geofencingService.fetchLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          primary: context.theme.extension<MyColors>()!.secondaryColor,
          padding: const EdgeInsets.all(0),
          textStyle: const TextStyle(fontSize: 15),
        ),
        onPressed: _givePermissions,
        child: const Text('Give permissions'));
  }
}
