import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/common_widgets/profile_avater/profile_avater.dart';
import 'package:flutter_application_1/src/constants/colors.dart';
import 'package:flutter_application_1/src/constants/image_strings.dart';
import 'package:flutter_application_1/src/constants/text_string.dart';
import 'package:flutter_application_1/src/features/core/models/user_model.dart';
import 'package:flutter_application_1/src/utils/shared_service.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer(
      {super.key,
      required this.selectedIndex,
      required this.onItemTapped,
      required this.user});
  final int selectedIndex;
  final Function(int) onItemTapped;
  final User user;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.fullName),
            accountEmail: Text(user.email),
            decoration: const BoxDecoration(
              color: cPrimaryColor,
            ),
            currentAccountPicture: CircleAvatar(
              child: user.profilePicture == null
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
          ),
          ListTile(
            selected: selectedIndex == 0,
            selectedColor: cPrimaryColor,
            leading: const Icon(Icons.home_filled),
            title: Text("Home".tr),
            onTap: () {
              onItemTapped(0);
            },
          ),
          ListTile(
            selected: selectedIndex == 1,
            selectedColor: cPrimaryColor,
            leading: const Icon(Icons.local_hospital),
            title: Text("RequestBlood".tr),
            onTap: () {
              onItemTapped(1);
            },
          ),
          ListTile(
            selected: selectedIndex == 2,
            selectedColor: cPrimaryColor,
            leading: const Icon(Icons.accessibility_new),
            title: Text("DonateBlood".tr),
            onTap: () {
              onItemTapped(2);
            },
          ),
          ListTile(
            selected: selectedIndex == 3,
            selectedColor: cPrimaryColor,
            leading: const Icon(Icons.history),
            title: Text("MyRequest".tr),
            onTap: () {
              onItemTapped(3);
            },
          ),
          ListTile(
            selected: selectedIndex == 4,
            selectedColor: cPrimaryColor,
            leading: const Icon(Icons.favorite),
            title: Text("MyDonations".tr),
            onTap: () {
              onItemTapped(4);
            },
          ),
          ListTile(
            selected: selectedIndex == 5,
            selectedColor: cPrimaryColor,
            leading: const Icon(Icons.location_on),
            title: Text("Nearby".tr),
            onTap: () {
              onItemTapped(5);
            },
          ),
          // ListTile(
          //   selected: selectedIndex == 6,
          //   selectedColor: cPrimaryColor,
          //   leading: const Icon(Icons.message),
          //   title: const Text(cMessage),
          //   onTap: () {
          //     onItemTapped(6);
          //   },
          // ),
          ListTile(
            selected: selectedIndex == 6,
            selectedColor: cPrimaryColor,
            leading: const Icon(Icons.diamond_outlined),
            title: Text("Sponser".tr),
            onTap: () {
              onItemTapped(6);
            },
          ),
          ListTile(
            selected: selectedIndex == 7,
            selectedColor: cPrimaryColor,
            leading: const Icon(Icons.settings),
            title: Text("Setting".tr),
            onTap: () {
              onItemTapped(7);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text("Logout".tr),
            onTap: () async {
              await SharedService.logout(context);
            },
          ),
        ],
      ),
    );
  }
}
