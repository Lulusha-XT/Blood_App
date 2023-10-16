import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/constants/colors.dart';
import 'package:flutter_application_1/src/constants/sizes.dart';

class COutlinedButtonTheme {
  COutlinedButtonTheme._(); //to a void creating instance
  /* Ligth Theme*/
  static final ligthOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: cPrimaryColor,
      side: const BorderSide(color: cPrimaryColor),
      padding: const EdgeInsets.symmetric(vertical: cButtonHeigth),
    ),
  );
  /* Ligth Theme*/
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: cWhiteColor,
      side: const BorderSide(color: cWhiteColor),
      padding: const EdgeInsets.symmetric(vertical: cButtonHeigth),
    ),
  );
}
