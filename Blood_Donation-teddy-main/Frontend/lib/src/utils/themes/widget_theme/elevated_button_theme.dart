import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/constants/colors.dart';
import 'package:flutter_application_1/src/constants/sizes.dart';

class CElevatedButtonTheme {
  CElevatedButtonTheme._(); //to a void creating instance
  /* Ligth Theme*/
  static final ligthElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: cWhiteColor,
      backgroundColor: cPrimaryColor,
      side: const BorderSide(color: cPrimaryColor),
      padding: const EdgeInsets.symmetric(vertical: cButtonHeigth),
    ),
  );
  /* Ligth Theme*/
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: cSecondaryColor,
      backgroundColor: cWhiteColor,
      side: const BorderSide(color: cSecondaryColor),
      padding: const EdgeInsets.symmetric(vertical: cButtonHeigth),
    ),
  );
}
