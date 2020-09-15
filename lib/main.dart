import 'package:dzshop/providers/category_provider.dart';
import 'package:dzshop/providers/color_provider.dart';
import 'package:dzshop/providers/size_provider.dart';
import 'package:dzshop/providers/wishlist_provider.dart';
import 'package:dzshop/util/custom_theme.dart';
import 'package:dzshop/views/home_screen.dart';
import 'package:dzshop/views/onboarding_screen.dart';
import 'package:dzshop/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
bool _seen = _sharedPreferences.getBool('seen');
Widget _nextScreen;
if(_seen == null || ! _seen){
  _nextScreen = OnBoardingScreen();
}else{
  String _userToken = _sharedPreferences.getString('user_token');
  if(_userToken == null || _userToken.isEmpty){
    _nextScreen = RegisterScreen();
  }else{
    _nextScreen = HomeScreen();
  }
}
  runApp(DzShop(_nextScreen));
}


class DzShop extends StatelessWidget {
  Widget _nextScreen;
  DzShop(this._nextScreen);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CategoryProvider()),
        ChangeNotifierProvider.value(value: WishListProvider()),
        ChangeNotifierProvider.value(value: ColorProvider()),
        ChangeNotifierProvider.value(value: SizeProvider()),
      ],
      child: MaterialApp(
        theme: CustomTheme.CUSTOM_THEME,
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
