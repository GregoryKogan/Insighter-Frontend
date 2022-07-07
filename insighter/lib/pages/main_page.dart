import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insighter/geolocation/geofencing.dart';
import 'package:insighter/state_controllers/state_controller.dart';
import 'package:insighter/theming/themes.dart';
import 'package:insighter/views/main_page/about.dart';
import 'package:insighter/views/main_page/home.dart';
import 'package:insighter/views/main_page/profile.dart';
import 'package:insighter/views/main_page/stroll.dart';
import 'package:insighter/widgets/main_page/bottom_nav.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static List<StatelessWidget> views = [
    const Stroll(),
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
      color: context.theme.extension<Palette>()!.background,
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
