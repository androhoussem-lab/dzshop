class Address {
  String street,township,city,zip_code;

  Address(this.street, this.township, this.city, this.zip_code);

  Address.fromJson(Map<String,dynamic> jsonObject){
    this.street = jsonObject['street'];
    this.township = jsonObject['township'];
    this.city = jsonObject['city'];
    this.zip_code = jsonObject['zip_code'];
  }
}