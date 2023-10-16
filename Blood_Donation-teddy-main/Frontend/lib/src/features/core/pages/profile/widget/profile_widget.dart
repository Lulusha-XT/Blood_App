import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/features/core/models/user_model.dart';
import 'package:flutter_application_1/src/common_widgets/profile_avater/profile_avater.dart';
import 'package:flutter_application_1/src/constants/colors.dart';
import 'package:flutter_application_1/src/constants/image_strings.dart';
import 'package:flutter_application_1/src/constants/sizes.dart';
import 'package:flutter_application_1/src/features/core/pages/profile/widget/profil_card_widget.dart';
import 'package:flutter_application_1/src/features/core/pages/profile/widget/profile_button_widget.dart';
import 'package:flutter_application_1/src/features/core/pages/profile/widget/profile_sizedbox_widget.dart';
import 'package:flutter_application_1/src/features/core/pages/update_profile/updat_profile_page.dart';
import 'package:flutter_application_1/src/utils/shared_service.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:get/get.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    print(("User profile ${user.profilePicture}"));
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 750,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(cDefaultSize),
                  decoration: const BoxDecoration(
                    color: cPrimaryColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              user.profilePicture == null
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
                              const SizedBox(width: 20),
                              Column(
                                children: [
                                  Text(
                                    user.fullName,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const Text(
                                    "",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => UpdateProfilePage(
                                    user: user,
                                  ));
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: cPrimaryColor,
                              ),
                              child: const Icon(
                                LineAwesomeIcons.alternate_pencil,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          ProfileSizedBoxs(
                            content: 'Requests',
                          ),
                          ProfileSizedBoxs(
                            content: 'Donations',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(cDefaultSize),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 150,
                                height: 80,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Birth Date',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "${user.dateOfBirth}",
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                height: 80,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Blood Type',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          user.bloodType,
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ProfileCardsWidget(
                            cardHeader: "Full Name",
                            cardContent: user.fullName,
                            icon: const Icon(
                              Icons.person,
                              color: Colors.red,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ProfileCardsWidget(
                            cardHeader: 'Medical Condition',
                            cardContent: user.medicalCondition,
                            icon: const Icon(
                              Icons.medical_information_outlined,
                              color: Colors.red,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ProfileCardsWidget(
                            cardHeader: 'Contact',
                            cardContent: user.phoneNo,
                            icon: const Icon(
                              Icons.phone,
                              color: Colors.red,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ProfileCardsWidget(
                            cardHeader: 'Email',
                            cardContent: user.email,
                            icon: const Icon(
                              Icons.email_outlined,
                              color: Colors.red,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: cWhiteColor,
            padding: const EdgeInsets.all(cDefaultSize),
            child: Column(
              children: [
                const ProfileButton(
                  buttonText: "Who can i donate",
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await SharedService.logout(context);
                    },
                    child: const Text("Logout"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
