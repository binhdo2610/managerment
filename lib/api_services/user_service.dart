import 'package:dio/dio.dart';
import 'package:managerment/api_services/base_api.dart';
import 'package:managerment/model/user_model.dart';
class UserService{
  UserModel user  = UserModel();

  static Future<UserModel> getUser(String id ) async{
    
    var url = '${BaseAPI.FLUTTER_API_URL}/api/User/$id';
  try {
      final response = await Dio().get(
      url,
      options: Options(
        headers: BaseAPI.FLUTTER_ACCESS_TOKEN,
      ),
      
    );
    if(response.statusCode != 200){
      return response.data;
    }
      return UserModel.fromJson(response.data);


    // if (response.statusCode == 200) {
    //   final data = response.data;
        //  user.email= data['email'];
        //  user.username = data['username'];
        //  user.id = data['id'];
        //  user.firstname = data['firstname'];
        //  user.lastname = data['lastname'];
        //  user.avatar = data['avatar'];
        //  user.phone = data['phone'];
        //  user.password = data['password'];    
      // }

  } catch (e) {
    throw Exception('Error fetching user data: $e');
  }
  
  }
}