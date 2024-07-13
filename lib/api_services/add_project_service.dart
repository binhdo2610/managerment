import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managerment/api_services/base_api.dart';
import 'package:managerment/theme/app_theme.dart';
class AddProject{
  Future<void> SubmitProject(String title, BuildContext context) async {

    var url = '${BaseAPI.FLUTTER_API_URL}' + '/api/projects/';
    // final uri = Uri.parse(url);
    final body = {
      'title': title,
    };
    final response = await Dio().post(
      url,
      data: jsonEncode(body),
      options: Options(headers: BaseAPI.FLUTTER_ACCESS_TOKEN),
    );
    if (response.statusCode == 200) {
      ShowSuccessMessage("Created successfully", context);
    } else {
      ShowSuccessMessage("Failed to create", context);
    }
  }
  void ShowSuccessMessage(String message, BuildContext context) {
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

  void ShowErrorMessage(String message, BuildContext context) {
    final snackBar = SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(
            color: Get.isDarkMode ? ThemeColor.dark1 : ThemeColor.background,
            fontSize: 18,
          ),
        ),
        backgroundColor:
            Get.isDarkMode ? ThemeColor.background : ThemeColor.dark1);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

