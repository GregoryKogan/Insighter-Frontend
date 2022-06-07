import 'package:flutter/material.dart';
import 'package:mw_insider/widgets/logout_button.dart';
import 'package:mw_insider/widgets/scrollable_view.dart';
import 'package:mw_insider/widgets/theme_switch.dart';
import 'package:mw_insider/widgets/user_profile_data.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollableView(
        minHeight: 400,
        screenHeightOffset: -90,
        // color: Colors.amber,
        child: Center(
            child: Column(
          children: const [
            SizedBox(height: 20),
            UserProfileData(),
            ThemeSwitch(),
            Spacer(flex: 1),
            LogoutButton(),
            SizedBox(height: 10),
          ],
        )),
      ),
    );
  }
}
