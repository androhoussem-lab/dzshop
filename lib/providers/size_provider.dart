

import 'package:flutter/material.dart';

class SizeProvider extends ChangeNotifier{
  String _size;

  void setSize(String size){
    this._size = size;
    notifyListeners();
  }

  get size => this._size;
}