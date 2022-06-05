import 'package:get/get.dart';

class StateController extends GetxController {
  final selectedViewIndex = 0.obs;

  updateSelectedViewIndex(int index) {
    selectedViewIndex(index);
  }
}
