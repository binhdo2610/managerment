import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managerment/theme/app_theme.dart';

class ProgressCart extends StatelessWidget {
  ProgressCart(
      {Key? key, required this.projectName, required this.completedPercent})
      : super(key: key);
  late String projectName;
  late int completedPercent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 3,
            margin: EdgeInsets.only(top: 10),
            height: 80 * 0.01 * this.completedPercent,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 123, 0, 245),
                borderRadius: BorderRadius.circular(10)),
          ),
          Expanded(
            child: Container(
              height: 70,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Get.isDarkMode?ThemeColor.dark1:ThemeColor.background,
                   borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 123, 0, 245),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Icon(
                      CupertinoIcons.doc_append,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        this.projectName,
                        style: GoogleFonts.poppins(
                          color: Get.isDarkMode?ThemeColor.background:ThemeColor.dark2,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "2 days ago",
                        style: GoogleFonts.poppins(
                          color: Get.isDarkMode?ThemeColor.background:ThemeColor.dark2,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                  Icon(
                    CupertinoIcons.ellipsis_vertical_circle,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
