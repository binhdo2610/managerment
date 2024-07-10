import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:managerment/api_services/base_api.dart';
import 'package:managerment/api_services/message_service.dart';

class AddProject {
  Future<bool> SubmitProject(String title, BuildContext context) async {
    var url = '${BaseAPI.FLUTTER_API_URL}' + '/api/projects/';

    final body = {
      'title': title,
    };
    final response = await Dio().post(
      url,
      data: jsonEncode(body),
      options: Options(headers: BaseAPI.FLUTTER_ACCESS_TOKEN),
    );
    if (response.statusCode == 200) {
      MessageService.ShowSuccessMessage("Created successfully", context);
    } else {
      MessageService.ShowErrorMessage("Failed to create", context);
    }
    return true;
  }

  static Future<List> FetchTodo() async {
    var url = '${BaseAPI.FLUTTER_API_URL}/api/projects/';
    final response = await Dio().get(
      url,
      options: Options(headers: BaseAPI.FLUTTER_ACCESS_TOKEN),
    );

    if (response.statusCode == 200) {
      if (response.data is String) {
        final json = jsonDecode(response.data) as List;
        return json;
      } else if (response.data is List) {
        return response.data;
      } else {
        print("Unexpected response format");
        return [];
      }
    } else {
      print('Failed to load data');
      return [];
    }
  }
  static Future<bool> deleteById(String id, BuildContext context) async {
    var url = '${BaseAPI.FLUTTER_API_URL}/api/projects/$id';
    final response = await Dio().delete(
      url,
      options: Options(headers: BaseAPI.FLUTTER_ACCESS_TOKEN),
    );
    if (response.statusCode == 204) {
      MessageService.ShowSuccessMessage("Delete successfully", context);
      return true;
    } else {
      MessageService.ShowErrorMessage("Delete failed", context);
      return false;
    }
  }

  static Future<bool> updateProject(String  id, String title, BuildContext context) async {
     var url = '${BaseAPI.FLUTTER_API_URL}' + '/api/projects/$id';
    final body = {
      'title': title,
    };
    final response = await Dio().put(
      url,
      data: jsonEncode(body),
      options: Options(headers: BaseAPI.FLUTTER_ACCESS_TOKEN),
    );
     if (response.statusCode == 200) {
      MessageService.ShowSuccessMessage("Update successfully", context);
      return true;
    } else {
      MessageService.ShowErrorMessage("Update failed", context);
      return false;
    }
  }
}
