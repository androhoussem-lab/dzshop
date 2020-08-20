class OfferModel {
  int offer_id;
  String offer_title,image_url;

  OfferModel(this.offer_id, this.offer_title, this.image_url);
  OfferModel.fromJson(Map<String,dynamic> jsonObject){
    this.offer_id = jsonObject['offer_id'];
    this.offer_title = jsonObject['offer_title'];
    this.image_url = jsonObject['image_url'];
  }
}