import 'package:dzshop/models/product_model.dart';

import 'offer_model.dart';

class HomeModel{
  List<OfferModel> category_offers;
  List<ProductModel> category_products;

  HomeModel(this.category_offers, this.category_products);

  HomeModel.fromJson(Map<String,dynamic> jsonObject){
    this.category_offers = getOffers(jsonObject['category_offers']);
    this.category_products = getProducts(jsonObject['category_products']);
  }
  List<OfferModel> getOffers(List<dynamic> jsonOffers){
    List<OfferModel> offers = [];
    for(var item in jsonOffers){
      offers.add(OfferModel.fromJson(item));
    }
    return offers;
  }
  List<ProductModel> getProducts(List<dynamic> jsonProducts){
    List<ProductModel> products = [];
    for(var item in jsonProducts){
      products.add(ProductModel.fromJson(item));
    }
    return products;
  }
}