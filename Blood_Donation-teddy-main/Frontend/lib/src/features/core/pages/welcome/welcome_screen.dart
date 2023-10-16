import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:flutter_application_1/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:flutter_application_1/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:flutter_application_1/src/constants/colors.dart';
import 'package:flutter_application_1/src/constants/image_strings.dart';
import 'package:flutter_application_1/src/constants/sizes.dart';
import 'package:flutter_application_1/src/constants/text_string.dart';
import 'package:flutter_application_1/src/features/authentication/pages/signin_page/signin_screen.dart';
import 'package:flutter_application_1/src/features/authentication/pages/signup_page/signup_screen.dart';
import 'package:get/get.dart';

class WellComePage extends StatelessWidget {
  const WellComePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startAnimation();
    var mediaQuery = MediaQuery.of(context);
    var brightnes = mediaQuery.platformBrightness;
    var height = mediaQuery.size.height;
    final isDarkMode = brightnes == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? cSecondaryColor : cWhiteColor,
      body: Stack(
        children: [
          CFadeInAnimation(
            durationInMs: 2000,
            animatePositionModel: CAnimationPositionModel(
              bottomBefore: -100,
              bottomAfter: 0,
              topBefore: 0,
              topAfter: 0,
              leftBefore: 0,
              leftAfter: 0,
              rightBefore: 0,
              rigthAfter: 0,
            ),
            child: Container(
              padding: const EdgeInsets.all(cDefaultSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(
                      image: const AssetImage(cWelcomeScreenImage),
                      height: height * 0.6),
                  Column(
                    children: [
                      Text(
                        cWelcomeTitle,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        cWelcomeSubtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Get.to(() => const SigninPage());
                          },
                          child: Text(
                            cSignin.toUpperCase(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => const SignUpPage());
                          },
                          child: Text(
                            cSignup.toUpperCase(),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
