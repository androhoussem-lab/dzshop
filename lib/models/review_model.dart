

import 'package:dzshop/models/user_model.dart';

class Review{
  UserForReview user;
  int stars;
  String review;

  Review(this.user, this.stars, this.review);
  Review.fromJson(Map<String,dynamic> jsonObject){
    this.user = UserForReview.fromJson(jsonObject['user']);
    this.stars = jsonObject['stars'];
    this.review = jsonObject['review'];
  }
}