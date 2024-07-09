import 'package:jwt_decoder/jwt_decoder.dart';
class decodeJwt{
  String getUsername({required String token}){
    Map<String,dynamic> decodeToken = JwtDecoder.decode(token);
    var username = decodeToken["Username"];
    if(username != null)
    {
      return username;
    }
    else { 
      throw Exception("username is null ");
    }
  }
    String getId({required String token}){
    Map<String,dynamic> decodeToken = JwtDecoder.decode(token);
    var id = decodeToken["Id"];
    if(id != null)
    {
      return id;
    }
    else { 
      throw Exception("id is null ");
    }
  }
  

}