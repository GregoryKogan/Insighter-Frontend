import 'package:flutter/material.dart';
import 'package:mw_insider/widgets/main_page/stroll_view/nearby_map.dart';
import 'package:mw_insider/widgets/main_page/stroll_view/tracking_button.dart';

class Stroll extends StatelessWidget {
  const Stroll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const NearbyMap(),
          Positioned(bottom: 10, child: Center(child: TrackingButton())),
        ],
      ),
    );
  }
}
