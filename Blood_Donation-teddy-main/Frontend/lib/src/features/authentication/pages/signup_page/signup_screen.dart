import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/common_widgets/form/form_header_widget.dart';
import 'package:flutter_application_1/src/constants/image_strings.dart';
import 'package:flutter_application_1/src/constants/sizes.dart';
import 'package:flutter_application_1/src/constants/text_string.dart';
import 'package:flutter_application_1/src/features/authentication/pages/signin_page/signin_screen.dart';
import 'package:flutter_application_1/src/features/authentication/pages/signup_page/widgets/signup_form_widget.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(cDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHeaderWidget(
                  image: cWelcomeScreenImage,
                  title: "GetOn".tr,
                  subTitle: "CreateyourprofiletostartyourJorneywithus".tr,
                ),
                const SizedBox(height: cDefaultSize - 10),
                const SignUpFormWidget(),
                const SizedBox(height: cDefaultSize - 10),
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(() => const SigninPage());
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "AlreadyhaveanAccount?".tr,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            TextSpan(text: "Signin".tr),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
