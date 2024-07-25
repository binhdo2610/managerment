//idProject -> IdTask 
import 'dart:convert';


import 'package:dio/dio.dart';
import 'package:managerment/KanbanBoard/item.dart';
import 'package:managerment/utils/sharePreferenceUtils.dart';

import 'base_api.dart';

// class KanbanService{ 
//   static Future<List> FetchTaskByStatus({required String projectId}) async {
//     var url = '${BaseAPI.FLUTTER_API_URL}/api/Todolists/project/$projectId';
//     final response = await Dio().get(
//       url,
//       options: Options(headers: BaseAPI.FLUTTER_ACCESS_TOKEN),
//     );

//     if (response.statusCode == 200) {
//       if (response.data is String) {
//          List<dynamic> jsonData = json.decode(response.data);
//     return jsonData.map((itemJson) => Item.fromJson(itemJson)).toList();
//       } else if (response.data is List) {
//         return response.data;
//       } else {
       
//         return [];
//       }
//     } else {
      
//       return [];
//     }
//   }
  
// }
