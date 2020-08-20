class CategoryModel{
  int category_id;
  String category_name;

  CategoryModel(this.category_id, this.category_name);
  
  CategoryModel.fromJson(Map<String,dynamic>jsonObject){
    this.category_id = jsonObject['category_id'];
    this.category_name = jsonObject['category_name'];
  }
}