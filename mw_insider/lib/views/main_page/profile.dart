import 'package:flutter/material.dart';
import 'package:mw_insider/widgets/main_page/profile_view/logout_button.dart';
import 'package:mw_insider/widgets/main_page/profile_view/theme_switch.dart';
import 'package:mw_insider/widgets/main_page/profile_view/user_profile_data.dart';
import 'package:mw_insider/widgets/wrappers/scrollable_view.dart';

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
