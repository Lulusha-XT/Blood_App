import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/common_widgets/profile_avater/profile_avater.dart';
import 'package:flutter_application_1/src/constants/image_strings.dart';
import 'package:flutter_application_1/src/features/core/models/user_model.dart';
import 'package:flutter_application_1/src/features/core/controllers/update_profile_controller.dart';
import 'package:flutter_application_1/src/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controllers = Get.put(UpdateProfileController());
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final user = ref.watch(userProvider);
        return Stack(
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
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.red,
                ),
                child: IconButton(
                  icon: const Icon(
                    LineAwesomeIcons.camera,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () async {
                    //  pick imaGe
                    // install image_picker
                    // import the corresponding library
                    ImagePicker imagePicker = ImagePicker();
                    XFile? file =
                        await imagePicker.pickImage(source: ImageSource.camera);
                    print("${file?.path}");
                    if (file == null) return;

                    controllers.imageFile.value = File(file.path);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
