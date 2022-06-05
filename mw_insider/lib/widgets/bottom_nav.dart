import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/state_controller/state_controller.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final stateController = Get.put(StateController());

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      stateController.updateSelectedViewIndex(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.directions_run_rounded), label: 'Stroll'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(
            icon: Icon(Icons.question_answer), label: 'About'),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.indigoAccent[700],
      onTap: _onItemTapped,
      unselectedItemColor: Colors.deepPurple[900],
    );
  }
}
