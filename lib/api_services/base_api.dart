import 'package:managerment/api_services/helper_function.dart';

class BaseAPI {
  static const String FLUTTER_API_URL = 'https://purpleboard-api.azurewebsites.net/';
  static String? globalToken;
  static Map<String, String>? FLUTTER_ACCESS_TOKEN;

  Future<String?> getToken() async {
    globalToken = await HelperFunctions.getToken();
    FLUTTER_ACCESS_TOKEN = {
      'Authorization': 'Bearer $globalToken',
    };
    return globalToken;
  }
}
