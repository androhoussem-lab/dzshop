import 'package:dzshop/models/review_model.dart';
import 'package:flutter/cupertino.dart';

class ProductModel{
  int product_id;
  String product_name;
  String image_url;
  double product_price;
  double product_discount;
  bool  isFavorite = false;

  ProductModel(
      this.product_id, this.product_name, this.image_url, this.product_price , this.product_discount);

  ProductModel.fromJson(Map<String,dynamic> jsonObject){
    this.product_id = jsonObject['product_id'];
    this.product_name = jsonObject['product_name'];
    this.image_url = _getImage(jsonObject['image']);
    this.product_price = double.tryParse(jsonObject['product_price'].toString());
    this.product_discount = double.tryParse(jsonObject['product_discount'].toString());
  }

  String _getImage(Map<String,dynamic> imageResource){
    if(imageResource == null){
      return 'https://cdn.pixabay.com/photo/2018/02/01/20/43/shopping-3124078_960_720.jpg';
    }
    return imageResource['url'];
  }
}

class ProductDetails{
  int product_id;
  String product_name;
  List <String> image_url;
  double product_price;
  double product_discount;
  List<dynamic> optionColors;
  List<dynamic> optionSizes;
  List<Review> reviews;
  String description;
  bool  isFavorite = false;

  ProductDetails(
      this.product_id,
      this.product_name,
      this.image_url,
      this.product_price,
      this.product_discount,
       {
       this.optionColors,
       this.optionSizes,
       this.description,
       this.isFavorite,
       this.reviews
       });

  ProductDetails.fromJson(Map<String,dynamic> jsonObject){
    this.product_id = jsonObject['product_id'];
    this.product_name = jsonObject['name'];
    this.image_url = _getImages(jsonObject['images']);
    this.product_price = double.tryParse(jsonObject['price'].toString());
    this.optionColors = getColors(jsonObject['options']);
    this.optionSizes = getSizes(jsonObject['options']);
    print(optionSizes);
    this.product_discount = double.tryParse(jsonObject['product_discount']);
    this.description = jsonObject['description'];
    this.reviews = _getReviews(jsonObject['reviews']);
  }




  //get list of images
  List<String> _getImages(List<dynamic> images){
    List<String> imageUrls = [];
    if(images.length == 0){
      imageUrls.add('https://cdn.pixabay.com/photo/2018/02/01/20/43/shopping-3124078_960_720.jpg');
      return imageUrls;
    }
    for(var image in images){
        imageUrls.add(image["url"]);
    }
    return imageUrls;
  }

  List<dynamic> getColors(Map<String,dynamic> colors){
    if(colors.containsKey('color')){ // colors
      return colors['color'];
    }else{
      return null;
    }
  }
  List<dynamic> getSizes(Map<String,dynamic> optionSizes){
    if(optionSizes.containsKey('size')){ // sizes
      return optionSizes["size"];
    }else{
      return null;
    }
  }
  List<Review> _getReviews(List<dynamic>reviewsFromJson){
    List<Review> reviewsList=[];
    if(reviewsFromJson.length == 0 || reviewsFromJson.isEmpty){
      return null;
    }else{
      for(var item in reviewsFromJson){
        reviewsList.add(Review.fromJson(item));
      }
      return reviewsList;
    }

  }

}