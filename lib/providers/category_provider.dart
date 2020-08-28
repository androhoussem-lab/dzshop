import 'package:dzshop/api/api_utilities.dart';
import 'package:dzshop/exceptions/exceptions.dart';
import 'package:dzshop/models/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryProvider extends ChangeNotifier{
  List<CategoryModel> _categories;
  int _index = 1;
  bool loading = true;

  setCategories(List<CategoryModel> categories) {
    this._categories = categories;
    loading = false;
    notifyListeners();
  }

  List<CategoryModel> getCategories() => this._categories;


  Future<List<CategoryModel>> fetchCategories()async{
   List<CategoryModel> categories = [];
   http.Response response = await http.get(ApiUtilities.CATEGORIES);
   switch(response.statusCode){
     case 200:
     case 201:
       var body = jsonDecode(response.body);
       var data = body['data'];
       for(var item in data){
         categories.add(CategoryModel.fromJson(item));
       }
       return categories;
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
       throw Exception();
       break;
   }
  }

  void setCategoryId(int index){
    this._index = index;
    notifyListeners();
  }

  getCategoryId(){
    return this._categories[_index].category_id;
  }

  int getCategoriesLength(){
    return this._categories.length;
  }
}