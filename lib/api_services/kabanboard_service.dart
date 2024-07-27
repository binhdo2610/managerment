import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:managerment/KanbanBoard/item.dart';
import 'package:managerment/utils/sharePreferenceUtils.dart';
import 'base_api.dart';

class KanbanService {
  Future<List<Item>> getToDoListByStatus(String projectId, int status) async {
    var url = '${BaseAPI.FLUTTER_API_URL}api/Todolists/project/$projectId';
    final response = await Dio().get(
      url,
      options: Options(headers: BaseAPI.FLUTTER_ACCESS_TOKEN),
    );

    if (response.statusCode == 200) {
      List<Item> items = parseItems(response.data, status);
      return items;
    } else {
      throw Exception('Gagal Login');
    }
  }
  Future<bool> updateStatusToDoList(String id ,String title,String userId,String projectId,String description ,int status, String statusName,String expiredAt,) async{
     var url = '${BaseAPI.FLUTTER_API_URL}api/Todolists/$id';
    
    final response = await Dio().put(
      url,
      data: {
      'title':title ,
      'description':description,
      'userId':userId,
      'expiredAt':expiredAt,
      'status':status,
      'statusName':statusName
      },  
      options: Options(headers: BaseAPI.FLUTTER_ACCESS_TOKEN),
    );

    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Error');
    }

  }

  List<Item> parseItems(dynamic responseBody, int status) {
    final parsed = responseBody.cast<Map<String, dynamic>>();
    return parsed
        .map<Item>((json) => Item.fromJson(json))
        .where((item) => item.status == status) // Lọc theo status
        .toList();
  }
}
