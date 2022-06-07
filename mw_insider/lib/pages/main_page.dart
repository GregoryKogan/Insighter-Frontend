import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/state_controllers/state_controller.dart';
import 'package:mw_insider/views/about.dart';
import 'package:mw_insider/views/home.dart';
import 'package:mw_insider/views/profile.dart';
import 'package:mw_insider/views/stroll.dart';
import 'package:mw_insider/widgets/bottom_nav.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final stateController = Get.put(StateController());

  static const views = [
    Stroll(),
    Home(),
    Profile(),
    About(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          body: Obx((() => views[stateController.selectedViewIndex.value])),
          bottomNavigationBar: const BottomNav(),
        ),
      ),
    );
  }
}
