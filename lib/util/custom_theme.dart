

import 'package:dzshop/util/screen_configuration.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static final ThemeData CUSTOM_THEME = ThemeData(
    primaryColor: Color(0xFFfe5c45),
    primaryColorLight: Color(0xFFFFFFFF),
    scaffoldBackgroundColor:Color(0xFFFFFFFF),
    backgroundColor: Color(0xFFFFFFFF),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFfe5c45),
    ),
  );
  static final TextTheme TEXT_THEME = TextTheme(
    button: TextStyle(color: Colors.white,fontSize: 16),
    subtitle1: TextStyle(color: Colors.white,fontSize: 16),
    subtitle2: TextStyle(color: Colors.black,fontSize: 16),
  );
}
