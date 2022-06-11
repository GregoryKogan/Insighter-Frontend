import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/state_controllers/location_controller.dart';
import 'package:mw_insider/widgets/loading_widgets/loading_bar.dart';
import 'package:mw_insider/widgets/loading_widgets/loading_circle.dart';
import 'package:mw_insider/widgets/main_page/home_view/nearby_object.dart';
import 'package:mw_insider/widgets/wrappers/scrollable_view.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: locationController.latitude.value == 0
            ? const Center(child: LoadingBar())
            : ScrollableView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      '${locationController.latitude.value}, ${locationController.longitude.value}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) => NearbyObject(
                          id: locationController.nearbyObjects[index])),
                      itemCount: locationController.nearbyObjects.length,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
