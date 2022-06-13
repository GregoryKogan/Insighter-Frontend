import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/state_controllers/location_controller.dart';
import 'package:mw_insider/theming/themes.dart';

class AddressSpan extends StatelessWidget {
  AddressSpan({Key? key}) : super(key: key);

  final locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RichText(
          text: TextSpan(
        children: [
          const WidgetSpan(child: Icon(Icons.location_on_outlined)),
          TextSpan(
            text: locationController.address.value,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.theme.extension<Palette>()!.foreground),
          ),
        ],
      )),
    );
  }
}
