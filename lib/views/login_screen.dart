import 'package:dzshop/api/authentication.dart';
import 'package:dzshop/util/custom_theme.dart';
import 'package:dzshop/util/screen_configuration.dart';
import 'package:dzshop/util/shared_widgets.dart';
import 'package:dzshop/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ScreenConfiguration _screenConfiguration;
  WidgetSize _widgetSize;
  final _formKey = GlobalKey<FormState>();
  bool _formValidator = false;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  Authentication _authentication;
  bool _enabled = true;
  @override
  void initState() {
    _authentication = Authentication();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenConfiguration = ScreenConfiguration(context);
    _widgetSize = WidgetSize(_screenConfiguration);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.CUSTOM_THEME.backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Form(
              autovalidate: _formValidator,
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: _widgetSize.titleFontSize, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  customTextFormField(
                      label: "Email",
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 25,
                  enabled: _enabled),
                  SizedBox(
                    height: 16,
                  ),
                  customTextFormField(
                      label: "Mot de passe",
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      maxLength: 14,
                  enabled: _enabled),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  ButtonStyle(
                      context: context,
                      child: (_enabled)?Text(
                        'Login',
                        style: CustomTheme.CUSTOM_THEME.textTheme.button,
                      ):CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)
                      ),
                      onPressed: (_enabled)? () {
                        if(!_formKey.currentState.validate()){
                            setState(() {
                              _formValidator = true;
                            });
                        }else{
                          setState(() {
                            _enabled = false;
                          });
                          _login(context);
                        }
                      }:(){}),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("J'ai pas un compte?" ,style: CustomTheme.CUSTOM_THEME.textTheme.subtitle2,),
                      FlatButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                          },
                          child: Text(
                            'Nouveau compte',
                            style: TextStyle(
                                fontSize: 16,
                                color: CustomTheme.CUSTOM_THEME.primaryColor),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  //custom text form field
  Widget customTextFormField(
      {String label,
        TextEditingController controller,
        int maxLength,
        TextInputType keyboardType,
        bool enabled}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        focusColor: Color(0xFFfe5c45),
      ),
      maxLength: maxLength,
      enabled: enabled,
      validator: (content) {
        if (content.isEmpty || content == '') {
          return '* Ce champ est obligatoire';
        }
        if (label == 'Email' && !content.contains('@')) {
          return '* Email non valide';
        }
        if (label == 'Email' && !content.contains('.com')) {
          return '* Email non valide';
        }
        return null;
      },
    );
  }

  void _login(BuildContext context){
    String email = _emailController.text;
    String password = _passwordController.text;
    _authentication.login(email, password).then((value) async{
      if(value != null && value.api_token != null){
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('user_token', value.api_token);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      }
    }).catchError((onError){
      setState(() {
        _enabled = true;
      });
      showAlert(context:context,title: 'Erreur dans l\'opération',content: onError.toString());
    });
  }
}
