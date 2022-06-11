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
        child: Column(
          children: const [
            SizedBox(height: 20),
            UserProfileData(),
            ThemeSwitch(),
            LogoutButton(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
