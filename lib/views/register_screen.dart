import 'package:dzshop/util/custom_theme.dart';
import 'package:dzshop/util/screen_configuration.dart';
import 'package:dzshop/util/shared_widgets.dart';
import 'package:dzshop/views/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ScreenConfiguration _screenConfiguration;
  WidgetSize _widgetSize;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  @override
  void initState() {
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
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(32),
        child: Form(
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
                  maxLength: 25),
              SizedBox(
                height: 16,
              ),
              customTextFormField(
                  label: "Email",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 25),
              SizedBox(
                height: 16,
              ),
              customTextFormField(
                  label: "Mot de passe",
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  maxLength: 14),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ButtonStyle(
                  context: context,
                  child: Text(
                    'Enregistrer',
                    style: CustomTheme.TEXT_THEME.button,
                  ),
                  onPressed: () {}),
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
}
