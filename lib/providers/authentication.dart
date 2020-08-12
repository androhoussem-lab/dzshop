import 'package:dzshop/api/api_utilities.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dzshop/models/user_model.dart';

class Authentication{
  Map<String,String> headers = {
    'accept' : 'application/json'
  };
//register new user
  Future<User> register(String name ,String email , String password)async{
   Map<String,String> body = {
     'name' : name ,
     'email' : email ,
     'password' : password
   };
   http.Response response = await http.post(ApiUtilities.REGISTER_URL,headers: headers,body: body);
   if(response.statusCode == 200){
    var body = jsonDecode(response.body);
    print(body.runtimeType);
    var data = body['data'];
    return User.fromJson(data);
   }else{
     throw ('Error in registration operation');
   }
  }
  //login
  Future<User> login(String email , String password)async{
    Map<String,String> body = {
      'email' : email,
      'password' : password
    };
    http.Response response = await http.post(ApiUtilities.LOGIN_URL , headers: headers , body: body);
    if(response.statusCode == 200){
      var body = jsonDecode(response.body);
      var data = body['data'];
      return User.fromJson(data);
    }else{
      throw ('Error in login operation');
    }
    
    
    
  }

}