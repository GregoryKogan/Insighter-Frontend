import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/geolocation/geofencing.dart';
import 'package:mw_insider/state_controllers/state_controller.dart';
import 'package:mw_insider/views/main_page/about.dart';
import 'package:mw_insider/views/main_page/home.dart';
import 'package:mw_insider/views/main_page/profile.dart';
import 'package:mw_insider/views/main_page/stroll.dart';
import 'package:mw_insider/widgets/main_page/bottom_nav.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static List<StatelessWidget> views = [
    Stroll(),
    Home(),
    const Profile(),
    const About(),
  ];

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final stateController = Get.put(StateController());

  @override
  void initState() {
    super.initState();
    final geofencingService = GeofencingService();
    geofencingService.fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          body: Obx(
              (() => MainPage.views[stateController.selectedViewIndex.value])),
          bottomNavigationBar: const BottomNav(),
        ),
      ),
    );
  }
}
