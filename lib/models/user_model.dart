

class User{
  int user_id;
  String name,email,api_token;
  //constructor
  User( this.name, this.email,{ this.user_id, this.api_token});

  //constructor for api
User.fromJson(Map<String,dynamic>jsonObject){
  this.user_id = jsonObject['user_id'];
  this.name = jsonObject['name'];
  this.email = jsonObject['email'];
  this.api_token = jsonObject['api_token'];
}


}