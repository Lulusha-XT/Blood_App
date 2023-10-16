import 'package:flutter/material.dart';

class CAppBarTheme {
  CAppBarTheme._(); // To prevent instantiation of this class

  // Light theme
  static const lightAppBarTheme = AppBarTheme(
    color: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 24,
    ),
  );

  // Dark theme
  static const darkAppBarTheme = AppBarTheme(
    color: Colors.black,
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 24,
    ),
  );
}
