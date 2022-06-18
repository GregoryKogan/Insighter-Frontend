import 'package:flutter/material.dart';
import 'package:insighter/api/users/profile_service.dart';
import 'package:insighter/widgets/loading_widgets/loading_circle.dart';
import 'package:intl/intl.dart';

class UserProfileData extends StatefulWidget {
  const UserProfileData({Key? key}) : super(key: key);

  @override
  State<UserProfileData> createState() => _UserProfileDataState();
}

class _UserProfileDataState extends State<UserProfileData> {
  final profileService = ProfileService();
  Map<String, dynamic>? userProfileData;

  void loadData() async {
    final data = await profileService.getProfile();
    setState(() {
      userProfileData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  String parseDateTime(String timestamp) {
    final DateTime moment = DateTime.parse(timestamp);
    final DateFormat formatter = DateFormat('dd.MM.yyyy, HH:mm:ss');
    return formatter.format(moment);
  }

  @override
  Widget build(BuildContext context) {
    return userProfileData == null
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
                            userProfileData!['name'],
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(userProfileData!['rank']),
                        ]),
                  ),
                ],
              ),
              Text(
                  'Joined on ${parseDateTime(userProfileData!["created_at"])}'),
            ],
          );
  }
}
