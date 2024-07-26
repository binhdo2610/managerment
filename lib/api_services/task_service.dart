import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:managerment/api_services/base_api.dart';
import 'package:managerment/api_services/message_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskService {
  static Future<bool> SubmitTask({
    required String projectId,
    required String title,
    required String description,
    required String expiredAt,
    required BuildContext context,
  }) async {
    var url = '${BaseAPI.FLUTTER_API_URL}' + 'api/Todolists/$projectId';
    final body = {
      'title': title,
      'description': description,
      // 'userId': '9b0ad4b5-16bb-4afb-8bcb-4c843fb34a2c',
      'expiredAt': expiredAt,
    };
    final response = await Dio().post(
      url,
      data: jsonEncode(body),
      options: Options(headers: BaseAPI.FLUTTER_ACCESS_TOKEN),
    );
    if (response.statusCode == 200) {
      MessageService.ShowMessage(
          AppLocalizations.of(context)!.createSuccessfully, context);
    } else {
      MessageService.ShowMessage(
          AppLocalizations.of(context)!.failedToCreate, context);
    }
    return true;
  }

  static Future<List> FetchTodo(
      {required String projectId, required BuildContext context}) async {
    var url = '${BaseAPI.FLUTTER_API_URL}/api/Todolists/project/$projectId';
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
        MessageService.ShowMessage("Unexpected response format", context);
        return [];
      }
    } else {
      MessageService.ShowMessage('Failed to load data', context);
      return [];
    }
  }

  static Future<bool> deleteTodoById(String id, BuildContext context) async {
    var url = '${BaseAPI.FLUTTER_API_URL}/api/Todolists/$id';
    final response = await Dio().delete(
      url,
      options: Options(headers: BaseAPI.FLUTTER_ACCESS_TOKEN),
    );
    if (response.statusCode == 204) {
      MessageService.ShowMessage(
          AppLocalizations.of(context)!.deleteSuccessfully, context);
    } else {
      MessageService.ShowMessage(
          AppLocalizations.of(context)!.failedToDelete, context);
    }
    return true;
  }

  static Future<bool> updateTodoList({
    required String id,
    required String title,
    required String description,
    required String expiredAt,
    required BuildContext context,
  }) async {
    var url = '${BaseAPI.FLUTTER_API_URL}/api/Todolists/$id';
    final body = {
      'title': title,
      'description': description,
      // 'userId': '9b0ad4b5-16bb-4afb-8bcb-4c843fb34a2c',
      'expiredAt': expiredAt,
    };
    final response = await Dio().put(
      url,
      data: jsonEncode(body),
      options: Options(headers: BaseAPI.FLUTTER_ACCESS_TOKEN),
    );
    if (response.statusCode == 204) {
      MessageService.ShowMessage(
          AppLocalizations.of(context)!.updateSuccessfully, context);
    } else {
      MessageService.ShowMessage(
          AppLocalizations.of(context)!.failedToUpdate, context);
    }
    return true;
  }
}
