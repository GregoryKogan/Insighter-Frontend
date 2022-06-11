import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/state_controllers/state_controller.dart';
import 'package:mw_insider/theming/themes.dart';

class ErrorMessage extends StatelessWidget {
  ErrorMessage({Key? key}) : super(key: key);
  final stateController = Get.put(StateController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => stateController.errorString.value == ''
        ? Container()
        : FractionallySizedBox(
            widthFactor: 0.9,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              decoration: BoxDecoration(
                color: context.theme
                    .extension<MyColors>()!
                    .errorColor!
                    .withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Center(
                child: Text(
                  stateController.errorString.value,
                  style: TextStyle(
                    color: context.theme.extension<MyColors>()!.errorColor!,
                  ),
                ),
              ),
            ),
          ));
  }
}
