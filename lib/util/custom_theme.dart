

import 'package:dzshop/util/screen_configuration.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static final ThemeData CUSTOM_THEME = ThemeData(
    textTheme: TextTheme(
        button: TextStyle(color: Colors.white,fontSize: 16),
        subtitle1: TextStyle(color: Colors.white,fontSize: 16),
        subtitle2: TextStyle(color: Colors.black,fontSize: 16),
        headline6: TextStyle(fontSize: 20 , color: Colors.grey.shade900 , fontWeight: FontWeight.w700),
      headline5: TextStyle(fontSize:20, fontWeight: FontWeight.bold)
    ),
    primaryColor: Color(0xFFfe5c45),
    primaryColorLight: Color(0xFFFFFFFF),
    scaffoldBackgroundColor:Color(0xFFFFFFFF),
    backgroundColor: Color(0xFFFFFFFF),
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.grey.shade900,
      iconTheme: IconThemeData(
        size: 16 ,
        color: Colors.black
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFfe5c45),
    ),
  );
}
