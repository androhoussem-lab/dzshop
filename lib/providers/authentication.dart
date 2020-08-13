import 'package:dzshop/api/api_utilities.dart';
import 'package:dzshop/exceptions/exceptions.dart';
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
   print(response.statusCode);
    switch(response.statusCode){
      case 200:
      case 201:
      var body = jsonDecode(response.body);
      print(body.runtimeType);
      var data = body['data'];
      return User.fromJson(data);
      break;
      case 300:
      case 301:
        throw RedirectionException();
        break;
      case 400:
      case 404:
        throw BadRequestException();
        break;
      case 500:
      case 501:
      case 502:
        throw BadGatewayException();
        break;
      case 504:
        throw GatewayTimeout();
        break;
      default:
        return null;
        break;
    }


  }
  //login
  Future<User> login(String email , String password)async{
    Map<String,String> body = {
      'email' : email,
      'password' : password
    };
    http.Response response = await http.post(ApiUtilities.LOGIN_URL , headers: headers , body: body);
    switch(response.statusCode){
      case 200:
      case 201:
      var body = jsonDecode(response.body);
      var data = body['data'];
      return User.fromJson(data);
      break;
      case 300:
      case 301:
        throw RedirectionException();
      break;
      case 400:
      case 404:
        throw BadRequestException();
      break;
      case 500:
      case 501:
      case 502:
        throw BadGatewayException();
      break;
      case 504:
        throw GatewayTimeout();
      break;
      default:
        return null;
      break;
    }



  }

}