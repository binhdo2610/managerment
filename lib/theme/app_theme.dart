import 'package:flutter/material.dart';

class ThemeColor {
  // Main colors
  static const Color primary = Color(0xFF4a009d);
  static const Color primaryLight1 = Color(0xFF6c00e5);
  static const Color primaryLight2 = Color(0xFF902eff);
  static const Color primaryLight3 = Color(0xFFb675ff);
  static const Color primaryLight4 = Color(0xFFdcbdff);
  static const Color primaryLight5 = Color(0xFFf2e5ff);

  static const Color secondary = Color(0xFFFF5600);
  static const Color secondaryLight1 = Color(0xFFFF7833);
  static const Color secondaryLight2 = Color(0xFFff9a66);
  static const Color secondaryLight3 = Color(0xFFFFBC99);
  static const Color secondaryLight4 = Color(0xFFFFD0B8);
  static const Color secondaryLight5 = Color(0xFFFFEBE0);

  // Alert & Status colors
  static const Color success = Color(0xFF00BA34);
  static const Color info = Color(0xFF0085FF);
  static const Color warning = Color(0xFFFFD700);
  static const Color error = Color(0xFFFF3B3B);
  static const Color disable = Color(0xFFB2B2B2);
  static const Color onButton = Color(0xFFA6B2CF);

  // Greyscale colors
  static const Color grey900 = Color(0xFF000000);
  static const Color grey800 = Color(0xFF1C1C1C);
  static const Color grey700 = Color(0xFF383838);
  static const Color grey600 = Color(0xFF545454);
  static const Color grey500 = Color(0xFF707070);
  static const Color grey400 = Color(0xFF8C8C8C);
  static const Color grey300 = Color(0xFFA8A8A8);
  static const Color grey200 = Color(0xFFC4C4C4);
  static const Color grey100 = Color(0xFFE0E0E0);
  static const Color grey50 = Color(0xFFFCFCFC);

  // Background color
  static const Color background = Color(0xFFEBF0FF);

  // Dark colors
  static const Color dark1 = Color(0xFF181A20);
  static const Color dark2 = Color(0xFF1F222A);
  static const Color dark3 = Color(0xFF35383F);


  static final light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primary,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: dark1,
    brightness: Brightness.dark,
  );
}
