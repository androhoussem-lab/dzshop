
class ApiUtilities{
  static final String MAIN_URL = 'https://ecommercedz.herokuapp.com/api/';
  static final String REGISTER_URL = MAIN_URL+'auth/register';
  static final String LOGIN_URL = MAIN_URL+'auth/login';
  static final String GET_CITIES = MAIN_URL + 'cities';

  //Address
  static final String NEW_ADDRESS = MAIN_URL+'new-address';
  static final String CATEGORIES = MAIN_URL+'categories';
  static String CATEGORY_PRODUCT(int index){
    return MAIN_URL+'category/'+index.toString()+'/products';
  }
}