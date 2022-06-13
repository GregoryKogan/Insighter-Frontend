import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/state_controllers/state_controller.dart';
import 'package:mw_insider/theming/color_service.dart';
import 'package:mw_insider/theming/themes.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final stateController = Get.put(StateController());

  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = stateController.selectedViewIndex.value;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      stateController.updateSelectedViewIndex(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: ColorService.darken(
              context.theme.extension<Palette>()!.background!,
              amount: 0.04)),
      child: BottomNavigationBarTheme(
        data: BottomNavigationBarThemeData(
          selectedItemColor: context.theme.extension<Palette>()!.cyan,
          unselectedItemColor: context.theme.extension<Palette>()!.comment,
          type: BottomNavigationBarType.fixed,
          elevation: 5,
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.directions_run_rounded), label: 'Stroll'),
            BottomNavigationBarItem(
                icon: Icon(Icons.gps_fixed), label: 'Nearby'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.question_answer), label: 'About'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
