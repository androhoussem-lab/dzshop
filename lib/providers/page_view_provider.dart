import 'package:flutter/material.dart';

class PageProvier extends ChangeNotifier {
  int _currentPage = 0;
  get currentPage => this._currentPage;
  setCurrentPage(int index) {
    this._currentPage = index;
    notifyListeners();
  }
}
