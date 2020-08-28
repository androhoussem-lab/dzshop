import 'package:dzshop/exceptions/exceptions.dart';
import 'package:dzshop/models/home_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api_utilities.dart';

Future<HomeModel> fetchHome(int index) async {
    http.Response response =
        await http.get(ApiUtilities.CATEGORY_PRODUCT(index));

    switch (response.statusCode) {
      case 200:
      case 201:
        var body = jsonDecode(response.body);
        var data = body['data'];
        return HomeModel.fromJson(data);
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