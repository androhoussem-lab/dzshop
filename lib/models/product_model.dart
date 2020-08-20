class ProductModel{
  int product_id;
  String product_name;
  String image_url;
  double product_price;

  ProductModel(
      this.product_id, this.product_name, this.image_url, this.product_price);

  ProductModel.fromJson(Map<String,dynamic> jsonObject){
    this.product_id = jsonObject['product_id'];
    this.product_name = jsonObject['product_name'];
    this.image_url = _getImage(jsonObject['image']);
    this.product_price = double.tryParse(jsonObject['product_price'].toString());
  }

  String _getImage(Map<String,dynamic> imageResource){
    if(imageResource == null){
      return 'https://cdn.pixabay.com/photo/2018/02/01/20/43/shopping-3124078_960_720.jpg';
    }
    return imageResource['url'];
  }
}