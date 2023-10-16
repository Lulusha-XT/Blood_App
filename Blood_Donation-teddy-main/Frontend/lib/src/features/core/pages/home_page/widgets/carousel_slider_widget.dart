// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/src/constants/image_strings.dart';

// class CarouselSliderWidget extends StatelessWidget {
//   const CarouselSliderWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 200,
//           margin: const EdgeInsets.only(top: 20),
//           width: double.infinity,
//           child: CarouselSlider(
//             items: [
//               Container(
//                 margin: const EdgeInsets.only(bottom: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   image: const DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage(cBloodDonorDay),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(bottom: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   image: const DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage(cWorldBloodDonorDay),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(bottom: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   image: const DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage(cBloodDonorDay),
//                   ),
//                 ),
//               ),
//             ],
//             options: CarouselOptions(
//               viewportFraction: 0.75,
//               enlargeCenterPage: true,
//               padEnds: true,
//               autoPlay: true,
//               autoPlayCurve: Curves.decelerate,
//               autoPlayAnimationDuration: const Duration(milliseconds: 800),
//             ),
//           ),
//         ),
//         DotsIndicator(
//           dotsCount: 4,
//           position: 2,
//           decorator: DotsDecorator(
//             size: const Size.square(9.0),
//             activeSize: const Size(18.0, 9.0),
//             activeShape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             activeColor: Colors.red, // set the active color to red
//           ),
//         )
//       ],
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/constants/image_strings.dart';

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({Key? key}) : super(key: key);

  @override
  _CarouselSliderWidgetState createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0; // Track the current index of the carousel

  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      cBloodDonorDay,
      cWorldBloodDonorDay,
      cBloodDonorDay,
      cWorldBloodDonorDay
    ]; // Replace with your image paths

    return Column(
      children: [
        Container(
          height: 200,
          margin: const EdgeInsets.only(top: 20),
          width: double.infinity,
          child: CarouselSlider(
            items: imageList.map((imagePath) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(imagePath),
                  ),
                ),
              );
            }).toList(),
            carouselController:
                _carouselController, // Pass the carousel controller
            options: CarouselOptions(
              viewportFraction: 0.75,
              enlargeCenterPage: true,
              padEnds: true,
              autoPlay: true,
              autoPlayCurve: Curves.decelerate,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index; // Update the current index
                });
              },
            ),
          ),
        ),
        DotsIndicator(
          dotsCount: imageList.length, // Number of images
          position: _currentIndex.toDouble(), // Current index
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            activeColor: Colors.red, // Set the active color to red
          ),
        ),
      ],
    );
  }
}
