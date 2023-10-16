import 'package:flutter_application_1/src/features/core/pages/welcome/welcome_screen.dart';
import 'package:get/get.dart';

class FadeInAnimationController extends GetxController {
  static FadeInAnimationController get find => Get.find();

  RxBool animation = false.obs;

  Future startSplashAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animation.value = true;
    await Future.delayed(const Duration(milliseconds: 3000));
    animation.value = false;
    await Future.delayed(const Duration(milliseconds: 1000));
    Get.offAll(() => const WellComePage());
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animation.value = true;
  }
}
