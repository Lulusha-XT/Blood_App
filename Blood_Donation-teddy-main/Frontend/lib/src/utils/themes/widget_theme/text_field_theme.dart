import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/constants/colors.dart';

class CTextFormFieldTheme {
  CTextFormFieldTheme._();
  static InputDecorationTheme ligthInputDecorationTheme = InputDecorationTheme(
    border: const OutlineInputBorder(),
    prefixIconColor: cSecondaryColor,
    floatingLabelStyle: const TextStyle(color: cSecondaryColor),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 2.0, color: cPrimaryColor),
        borderRadius: BorderRadius.circular(15)),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    border: const OutlineInputBorder(),
    prefixIconColor: cPrimaryColor,
    floatingLabelStyle: const TextStyle(color: cPrimaryColor),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 2.0, color: cPrimaryColor),
        borderRadius: BorderRadius.circular(15)),
  );
}
