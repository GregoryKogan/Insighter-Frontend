import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/api/users/profile_service.dart';
import 'package:mw_insider/state_controllers/state_controller.dart';
import 'package:mw_insider/widgets/loading_widgets/loading_circle.dart';
import 'package:intl/intl.dart';

class UserProfileData extends StatefulWidget {
  const UserProfileData({Key? key}) : super(key: key);

  @override
  State<UserProfileData> createState() => _UserProfileDataState();
}

class _UserProfileDataState extends State<UserProfileData> {
  final stateController = Get.put(StateController());
  final ps = ProfileService();

  @override
  void initState() {
    super.initState();
    if (stateController.userProfileData.isEmpty) ps.fetchUserProfileData();
  }

  String parseDateTime(String timestamp) {
    final DateTime moment = DateTime.parse(timestamp);
    final DateFormat formatter = DateFormat('dd.MM.yyyy, HH:mm:ss');
    return formatter.format(moment);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => stateController.userProfileData.isEmpty
        ? const LoadingCircle()
        : Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.account_circle,
                      size: 100,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stateController.userProfileData['name'],
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(stateController.userProfileData['rank']),
                        ]),
                  ),
                ],
              ),
              Text(
                  'Joined on ${parseDateTime(stateController.userProfileData["created_at"])}'),
            ],
          ));
  }
}
