

class User{
  int user_id;
  String name,email,api_token;
  //constructor
  User( this.name, this.email,{ this.user_id, this.api_token});

  //constructor for api
User.fromJson(Map<String,dynamic>jsonObject){
  this.user_id = jsonObject['user_id'];
  this.name = jsonObject['user_name'];
  this.email = jsonObject['user_email'];
  this.api_token = jsonObject['api_token'];
}


}

class UserForReview{
  int user_id;
  String name ;
  String image;

  UserForReview(this.user_id, this.name, this.image);
  
  UserForReview.fromJson(Map<String,dynamic> jsonObject){
    this.user_id = jsonObject['user_id'];
    this.name = jsonObject['name'];
    this.image = _getImage(jsonObject['image']);
  }

  String _getImage(Map<String,dynamic> imageResource){
    if(imageResource == null){
      return 'https://cdn.pixabay.com/photo/2018/02/01/20/43/shopping-3124078_960_720.jpg';
    }
    return imageResource['url'];
  }
}

