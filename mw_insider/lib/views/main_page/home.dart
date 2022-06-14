import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mw_insider/state_controllers/location_controller.dart';
import 'package:mw_insider/widgets/loading_widgets/loading_bar.dart';
import 'package:mw_insider/widgets/main_page/give_permission_button.dart';
import 'package:mw_insider/widgets/main_page/home_view/address_span.dart';
import 'package:mw_insider/widgets/main_page/home_view/nearby_object.dart';
import 'package:mw_insider/widgets/wrappers/scrollable_view.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: locationController.locationPermission.value !=
                    LocationPermission.always &&
                locationController.locationPermission.value !=
                    LocationPermission.whileInUse
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      "Can't load this page without geolocation permission"),
                  GivePermissionButton(),
                ],
              ))
            : locationController.latitude.value == 0
                ? const Center(child: LoadingBar())
                : ScrollableView(
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          AddressSpan(),
                          const SizedBox(height: 20),
                          locationController.nearbyObjects.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: ((context, index) =>
                                      NearbyObject(
                                          id: locationController
                                              .nearbyObjects[index]['id'])),
                                  itemCount:
                                      locationController.nearbyObjects.length,
                                )
                              : const Text('Nothing here...'),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
