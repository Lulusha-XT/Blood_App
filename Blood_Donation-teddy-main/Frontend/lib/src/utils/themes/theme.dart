import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/utils/themes/widget_theme/appbar_theme.dart';
import 'package:flutter_application_1/src/utils/themes/widget_theme/elevated_button_theme.dart';
import 'package:flutter_application_1/src/utils/themes/widget_theme/outlined_button_theme.dart';
import 'package:flutter_application_1/src/utils/themes/widget_theme/text_field_theme.dart';
import 'widget_theme/txt_theme.dart';

class CAppTheme {
  CAppTheme._();
  static ThemeData ligthTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: CTextTheme.ligthTextTheme,
    outlinedButtonTheme: COutlinedButtonTheme.ligthOutlinedButtonTheme,
    elevatedButtonTheme: CElevatedButtonTheme.ligthElevatedButtonTheme,
    inputDecorationTheme: CTextFormFieldTheme.ligthInputDecorationTheme,
    appBarTheme: CAppBarTheme.lightAppBarTheme,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: CTextTheme.darkTextTheme,
    outlinedButtonTheme: COutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: CElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: CTextFormFieldTheme.darkInputDecorationTheme,
    appBarTheme: CAppBarTheme.darkAppBarTheme,
  );
}
