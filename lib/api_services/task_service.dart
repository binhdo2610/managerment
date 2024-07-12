import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:managerment/api_services/base_api.dart';
import 'package:managerment/api_services/message_service.dart';

class TaskService{
  static Future <bool> SubmitTask({required String projectId,required String title,required String description,required String expiredAt, required BuildContext context,})
  async {
    var url = '${BaseAPI.FLUTTER_API_URL}' + 'api/Todolists/$projectId/AddTodolist';
    final body = {
      'title': title,
      'description': description,
      'expiredAt': expiredAt,
    };
    final response = await Dio().post(
      url,
      data: jsonEncode(body),
      options: Options(headers: BaseAPI.FLUTTER_ACCESS_TOKEN),
    );
     if (response.statusCode == 201) {
      MessageService.ShowSuccessMessage("Created successfully", context);
    } else {
      MessageService.ShowErrorMessage("Failed to create", context);
    }
    return true;
  }
}