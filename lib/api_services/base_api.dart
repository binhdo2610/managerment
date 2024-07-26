import 'package:managerment/api_services/helper_function.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseAPI {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
   
  static const String FLUTTER_API_URL = 'https://purpleboard-api.azurewebsites.net/';
  static String? _token;
 


  // Future<String?> getToken() async {
  //    final SharedPreferences prefsInstance = await prefs;
  //   final String? tokenTest = prefsInstance.getString('token');
  //   globalToken =  tokenTest;
  //   FLUTTER_ACCESS_TOKEN = {
  //     'Authorization': 'Bearer $globalToken',
  //   };
  //   return globalToken;
  // }
   static Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('TOKENKEY');
  }
  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('TOKENKEY', token);
    _token = token;
  }
    static String? get token => _token;
     static var FLUTTER_ACCESS_TOKEN =    {'Authorization': 'Bearer ${BaseAPI.token}'};
}
