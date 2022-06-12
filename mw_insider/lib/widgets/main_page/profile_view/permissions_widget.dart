import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mw_insider/state_controllers/location_controller.dart';
import 'package:mw_insider/theming/themes.dart';
import 'package:mw_insider/widgets/loading_widgets/loading_circle.dart';
import 'package:mw_insider/widgets/main_page/give_permission_button.dart';

class PermissionsWidget extends StatefulWidget {
  const PermissionsWidget({Key? key}) : super(key: key);

  @override
  State<PermissionsWidget> createState() => _PermissionsWidgetState();
}

class _PermissionsWidgetState extends State<PermissionsWidget> {
  final locationController = Get.put(LocationController());

  Map<String, bool> permissionStatus() {
    Map<String, bool> result = {
      'foreground': false,
      'background': false,
    };
    if (locationController.locationPermission.value ==
        LocationPermission.whileInUse) {
      result['foreground'] = true;
    } else if (locationController.locationPermission.value ==
        LocationPermission.always) {
      result['foreground'] = true;
      result['background'] = true;
    }

    return result;
  }

  void fetchPermission() async {
    final permission = await Geolocator.checkPermission();
    locationController.setLocationPermission(permission);
  }

  @override
  void initState() {
    super.initState();
    fetchPermission();
  }

  @override
  Widget build(BuildContext context) {
    if (locationController.locationPermission.value == null) {
      return const LoadingCircle();
    }
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Row(
            children: [
              const Expanded(
                  flex: 2,
                  child: Text(
                    'Geolocation permission',
                    style: TextStyle(fontSize: 15),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: permissionStatus()["foreground"]!
                        ? Icon(
                            Icons.check_circle_outline,
                            color: context.theme
                                .extension<MyColors>()!
                                .successColor,
                          )
                        : Icon(
                            Icons.cancel_outlined,
                            color:
                                context.theme.extension<MyColors>()!.errorColor,
                          ),
                  ))
            ],
          ),
          if (locationController.locationPermission.value !=
                  LocationPermission.always &&
              locationController.locationPermission.value !=
                  LocationPermission.whileInUse)
            GivePermissionButton()
        ],
      ),
    );
  }
}
