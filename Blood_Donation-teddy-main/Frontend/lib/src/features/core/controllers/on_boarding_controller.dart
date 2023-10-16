import 'package:flutter_application_1/src/constants/colors.dart';
import 'package:flutter_application_1/src/constants/image_strings.dart';
import 'package:flutter_application_1/src/constants/text_strings.dart';
import 'package:flutter_application_1/src/features/core/models/model_on_boarding.dart';
import 'package:flutter_application_1/src/features/core/pages/on_boarding_page/on_boarding_widget.dart';
import 'package:flutter_application_1/src/features/core/pages/welcome/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

class OnBoardingController extends GetxController {
  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  final pages = [
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: cOnBoardingImage1,
        title: cOnBoardingTitle1,
        subTitle: cOnBoardingSubTitle1,
        counterText: cOnBoardingCounter1,
        // height: size.height,
        bgColor: cOnBoardingPage1Color,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: cOnBoardingImage2,
        title: cOnBoardingTitle2,
        subTitle: cOnBoardingSubTitle2,
        counterText: cOnBoardingCounter2,
        // height: size.height,
        bgColor: cOnBoardingPage2Color,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: cOnBoardingImage3,
        title: cOnBoardingTitle3,
        subTitle: cOnBoardingSubTitle3,
        counterText: cOnBoardingCounter3,
        // height: size.height,
        bgColor: cOnBoardingPage3Color,
      ),
    )
  ];

  onPageChangeCallback(int activePageIndex) {
    currentPage.value = activePageIndex;
  }

  skip() {
    controller.jumpToPage(page: 2);
  }

  animateToNextSlide() {
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
    if (nextPage == 3) {
      Get.to(() => const WellComePage());
    }
  }
}
