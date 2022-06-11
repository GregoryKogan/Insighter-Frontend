import 'package:get/get.dart';

class StateController extends GetxController {
  final selectedViewIndex = 1.obs;

  final authView = 'log_in'.obs;

  final userPassword = ''.obs;
  final userPasswordConfirmation = ''.obs;
  final userLogin = ''.obs;
  final errorString = ''.obs;

  final userProfileData = <String, dynamic>{}.obs;

  updateSelectedViewIndex(int index) {
    selectedViewIndex(index);
  }

  setAuthView(String view) {
    authView(view);
  }

  updateUserPassword(String val) {
    userPassword(val);
  }

  updateUserPasswordConfirmation(String val) {
    userPasswordConfirmation(val);
  }

  updateUserLogin(String val) {
    userLogin(val);
  }

  setErrorString(String err) {
    errorString(err);
    Future.delayed(const Duration(seconds: 10), () {
      if (errorString.value == err) {
        errorString('');
      }
    });
  }

  updateUserProfileData(Map<String, dynamic> data) {
    userProfileData(data);
  }
}
