import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/common_widgets/profile_avater/profile_avater.dart';
import 'package:flutter_application_1/src/constants/image_strings.dart';
import 'package:flutter_application_1/src/features/core/models/user_model.dart';
import 'package:flutter_application_1/src/features/core/pages/profile/profile_page.dart';
import 'package:get/get.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({
    super.key,
    required this.user,
  });
  final User user;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20, left: 7),
          child: IconButton(
            onPressed: () {
              Get.to(() => const ProfilePage());
              // AuthenticationRepository.instance.logout();
            },
            icon: user.profilePicture == null
                ? const CircleAvatarWithTransition(
                    image: AssetImage(cProfileImage),
                    primaryColor: Colors.white60,
                    size: 130,
                    transitionBorderwidth: 8.0,
                  )
                : CircleAvatarWithTransition(
                    image: NetworkImage(user.fullImagePath),
                    primaryColor: Colors.white60,
                    size: 130,
                    transitionBorderwidth: 8.0,
                  ),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}
