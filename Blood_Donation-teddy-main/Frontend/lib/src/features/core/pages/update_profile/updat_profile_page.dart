import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/constants/sizes.dart';
import 'package:flutter_application_1/src/features/core/models/user_model.dart';
import 'package:flutter_application_1/src/features/core/pages/update_profile/widgets/profile_picture_widget.dart';
import 'package:flutter_application_1/src/features/core/pages/update_profile/widgets/update_profile_widget.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                const ProfilePicture(),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      user.fullName,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          UpdateProfileWidget(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
