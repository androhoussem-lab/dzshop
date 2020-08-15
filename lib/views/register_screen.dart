import 'package:dzshop/api/authentication.dart';
import 'package:dzshop/util/custom_theme.dart';
import 'package:dzshop/util/screen_configuration.dart';
import 'package:dzshop/util/shared_widgets.dart';
import 'package:dzshop/views/address_screen.dart';
import 'package:dzshop/views/home_screen.dart';
import 'package:dzshop/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ScreenConfiguration _screenConfiguration;
  WidgetSize _widgetSize;
  final _formKey = GlobalKey<FormState>();
  bool _formValidator = true;
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  Authentication _authentication;
  bool _enabled = true;
  @override
  void initState() {
    _authentication = Authentication();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body:SingleChildScrollView(
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
                    'Nouveaux Compte',
                    style: TextStyle(fontSize: _widgetSize.titleFontSize, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              customTextFormField(
                  label: "Nom complet",
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  maxLength: 25,
                enabled : _enabled,
              ),
              SizedBox(
                height: 16,
              ),
              customTextFormField(
                  label: "Email",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 25,
                enabled : _enabled,
             ),
              SizedBox(
                height: 16,
              ),
              customTextFormField(
                  label: "Mot de passe",
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  maxLength: 14,
                enabled : _enabled,),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ButtonStyle(
                  context: context,
                  child: (_enabled)?Text(
                    'Suivent',
                    style: CustomTheme.TEXT_THEME.button,
                  ):CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)
                  ),
                  onPressed: (_enabled)?() async{
                    if(! _formKey.currentState.validate()){
                      setState(() {
                        _formValidator = false;
                      });
                    }else{
                      setState(() {
                        _enabled = false;
                      });
                      _register(context);
                    }

                  }:(){}),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("J'ai deja un compte?" ,style: CustomTheme.TEXT_THEME.subtitle2,),
                  FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: _widgetSize.buttonFontSize,
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
        bool enabled
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        enabled: enabled,
        focusColor: Color(0xFFfe5c45),
      ),
      maxLength: maxLength,
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

  void _register(BuildContext context){
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    _authentication.register(name, email, password).then((value) async{
      if(value != null || value.api_token == null){
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('user_token', value.api_token);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddressScreen(value.user_id)));
      }
    }).catchError((error){
      showAlert(
        context: context,
        title: 'Erreur dans l\'opération',
        content: error.toString()
      );
      setState(() {
        _enabled = true;
      });
    });
  }

}
