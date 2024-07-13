import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

class MessageService{
   static void ShowMessage(String message, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: GoogleFonts.poppins(
          color: Get.isDarkMode ? ThemeColor.dark1 : ThemeColor.background,
          fontSize: 18,
        ),
      ),
      backgroundColor:
          Get.isDarkMode ? ThemeColor.background : ThemeColor.dark1,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}