import 'package:dzshop/api/authentication.dart';
import 'package:dzshop/util/custom_theme.dart';
import 'package:dzshop/util/screen_configuration.dart';
import 'package:dzshop/util/shared_widgets.dart';
import 'package:dzshop/views/address_screen.dart';
import 'package:dzshop/views/home_screen.dart';
import 'package:dzshop/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressScreen extends StatefulWidget {
  final int userId;
  @override
  _AddressScreenState createState() => _AddressScreenState();

  AddressScreen(this.userId);
}

class _AddressScreenState extends State<AddressScreen> {
  ScreenConfiguration _screenConfiguration;
  WidgetSize _widgetSize;
  final _formKey = GlobalKey<FormState>();
  bool _formValidator = true;
  TextEditingController _streetController;
  TextEditingController _townshipController;
  TextEditingController _cityController;
  TextEditingController _zipController;
  Authentication _authentication;
  bool _enabled = true;
  @override
  void initState() {
    _authentication = Authentication();
    _streetController = TextEditingController();
    _townshipController = TextEditingController();
    _cityController = TextEditingController();
    _zipController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _streetController.dispose();
    _townshipController.dispose();
    _cityController.dispose();
    _zipController.dispose();
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
                        'Addresse',
                        style: TextStyle(fontSize: _widgetSize.titleFontSize, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  customTextFormField(
                    label: "Rue",
                    controller: _streetController,
                    keyboardType: TextInputType.streetAddress,
                    maxLength: 40,
                    enabled : _enabled,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  customTextFormField(
                    label: "Commune",
                    controller: _townshipController,
                    keyboardType: TextInputType.text,
                    maxLength: 25,
                    enabled : _enabled,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  customTextFormField(
                    label: "Wilaya",
                    controller: _cityController,
                    keyboardType: TextInputType.text,
                    maxLength: 25,
                    enabled : _enabled,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  customTextFormField(
                    label: "Code postale",
                    controller: _zipController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    enabled : _enabled,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  ButtonStyle(
                      context: context,
                      child: (_enabled)?Text(
                        'Enregistrer',
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
                          _registerNewAddress(context);
                        }

                      }:(){}),
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
        if(content.length < 5){
          return 'Saisie incorrecte';
        }
        return null;
      },
    );
  }

  void _registerNewAddress(BuildContext context){
    String street = _streetController.text;
    String township = _townshipController.text;
    String city = _cityController.text;
    String zipCode = _zipController.text;
    _authentication.saveAddress(widget.userId.toString() ,street, township, city, zipCode).then((value) => {
      if(value){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()))
      }
      }
    ).catchError((error){
      setState(() {
        _enabled = true;
      });
      showAlert(context: context , title: 'Erreur dans l\'opération' , content: error.toString());
    });
  }

}
