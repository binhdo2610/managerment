import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:managerment/api_services/base_api.dart';
import 'package:managerment/api_services/helper_function.dart';
import 'package:managerment/api_services/message_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ProjectService {
  
  static Future<bool> SubmitProject(String title, BuildContext context) async {
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
      MessageService.ShowMessage(
          AppLocalizations.of(context)!.createSuccessfully, context);
    } else {
      MessageService.ShowMessage(
          AppLocalizations.of(context)!.failedToCreate, context);
    }
    return true;
  }

  static Future<List> FetchProject() async {
    
    var url = '${BaseAPI.FLUTTER_API_URL}api/Projects/';
    
    final response = await Dio().get(
      url,
      options: Options(headers:BaseAPI.FLUTTER_ACCESS_TOKEN,),
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
      MessageService.ShowMessage(
          AppLocalizations.of(context)!.deleteSuccessfully, context);
    } else {
      MessageService.ShowMessage(
          AppLocalizations.of(context)!.failedToDelete, context);
    }
    return true;
  }

  static Future<bool> updateProject(
      String id, String title, BuildContext context) async {
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
      MessageService.ShowMessage(
          AppLocalizations.of(context)!.updateSuccessfully, context);
    } else {
      MessageService.ShowMessage(
          AppLocalizations.of(context)!.failedToUpdate, context);
    }
    return true;
  }
}
