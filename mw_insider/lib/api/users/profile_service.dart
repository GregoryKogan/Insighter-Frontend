import 'dart:convert';
import 'package:get/get.dart';
import 'package:mw_insider/api/jwt.dart';
import 'package:mw_insider/state_controllers/state_controller.dart';

class ProfileService {
  JwtService jwt = JwtService();
  final stateController = Get.put(StateController());

  Future<Map<String, dynamic>> getProfile() async {
    return jsonDecode((await jwt.makeBackendRequest('GET', 'users/me')).body);
  }

  Future<void> fetchUserProfileData() async {
    stateController.updateUserProfileData(await getProfile());
  }
}
