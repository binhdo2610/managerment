import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managerment/theme/app_theme.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.text,
    this.press,
    required this.icon, // Required Icon parameter
  });

  final String text;
  final VoidCallback? press;
  final Icon icon; // Add this line

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            icon, // Display the icon here
            const SizedBox(width: 20),
            Expanded(child: Text(text, style: GoogleFonts.poppins(color: Get.isDarkMode?ThemeColor.primaryLight1:ThemeColor.dark3,),)),
             Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
