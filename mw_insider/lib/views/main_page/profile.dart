import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/widgets/main_page/profile_view/logout_button.dart';
import 'package:mw_insider/widgets/main_page/profile_view/permissions_widget.dart';
import 'package:mw_insider/widgets/main_page/profile_view/theme_switch.dart';
import 'package:mw_insider/widgets/main_page/profile_view/user_profile_data.dart';
import 'package:mw_insider/widgets/wrappers/scrollable_view.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollableView(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const UserProfileData(),
              Divider(
                thickness: 1,
                height: 20,
                color: context.theme.canvasColor,
              ),
              const PermissionsWidget(),
              const ThemeSwitch(),
              const SizedBox(height: 40),
              const LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
