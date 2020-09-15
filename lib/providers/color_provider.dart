import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier{
  Color _color;

  setColor(Color color){
    this._color = color;
    notifyListeners();
  }

  get color => this._color;
}