import 'package:dzshop/models/product_model.dart';
import 'package:dzshop/util/custom_theme.dart';
import 'package:flutter/material.dart';

class WishListProvider extends ChangeNotifier{
  List<ProductModel> _wishList = [];


  void addToWishList(ProductModel product){
    _wishList.add(product);
    product.isFavorite = true;
    notifyListeners();
  }
  void removeFromWishList(ProductModel product){
    _wishList.remove(product);
    product.isFavorite = false;
    notifyListeners();
  }

  get wishList => this._wishList;
}
