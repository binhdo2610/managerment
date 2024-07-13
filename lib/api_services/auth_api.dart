
import 'dart:convert';


import 'package:dio/dio.dart';
import 'package:managerment/utils/sharePreferenceUtils.dart';

import 'base_api.dart';
class AuthApi{
   
  final shaedpref = SharedPrefs.instance;
  Future<bool> signupAPI(
      String email,String username,String lastname, String firstname, String password) async {
    var url = '${BaseAPI.FLUTTER_API_URL}' + '/register';

    var body = jsonEncode({
      'email': email,
      'username': username,
      'lastname':lastname,
      'firstname': firstname,
      'password': password,
      
    });
    final response = await Dio().post(
      url,
      data: body,

      options: Options(contentType:"application/json" ),   
    );

    if (response.statusCode == 200) {  
        return true;
    } else {
      throw Exception('failed Register');
    }
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    var url = '${BaseAPI.FLUTTER_API_URL}' + '/login';

    var body = jsonEncode({
       "email": email,
       "password": password
    });

    var response = await Dio().post(
      url,
      data: body,
      options: Options(contentType:"application/json" ),
    );
    int? statusCode = response.statusCode;
    if (statusCode == 200) {
       
      return response.data ;
    } else {
      throw Exception('Gagal Login');
    }
    
  }

  Future<String> getUser({required String id}) async { 
    var url = '${BaseAPI.FLUTTER_API_URL}' + 'api/User/{id}?id=${id}';
    var respones = await Dio().post(url);
    int? statusCode = respones.statusCode;
    if (statusCode == 200) {
       
      return respones.data ;
    } else {
      throw Exception('Gagal Login');
    }
  }
} 