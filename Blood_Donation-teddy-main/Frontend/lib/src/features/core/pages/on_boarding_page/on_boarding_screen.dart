import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/constants/colors.dart';
import 'package:flutter_application_1/src/features/core/controllers/on_boarding_controller.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final obsController = OnBoardingController();

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: obsController.pages,
            onPageChangeCallback: obsController.onPageChangeCallback,
            liquidController: obsController.controller,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
          ),
          Positioned(
            bottom: 60.0,
            child: OutlinedButton(
              onPressed: () {
                obsController.animateToNextSlide();
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black26),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20)),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                    color: cPrimaryColor, shape: BoxShape.circle),
                child: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () {
                obsController.skip();
              },
              child: const Text(
                "Skip",
                style: TextStyle(color: cPrimaryColor),
              ),
            ),
          ),
          Obx(
            () => Positioned(
              bottom: 10,
              child: AnimatedSmoothIndicator(
                activeIndex: obsController.currentPage.value,
                count: 3,
                effect: const WormEffect(
                    activeDotColor: Color(0xFFF44336), dotHeight: 5.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
