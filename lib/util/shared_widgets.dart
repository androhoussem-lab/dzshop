import 'package:dzshop/util/custom_theme.dart';
import 'package:flutter/material.dart';

Widget ButtonStyle({
  @required BuildContext context,
  @required Widget child ,
  @required Function onPressed}){
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 50,
    child: MaterialButton(
      color: CustomTheme.CUSTOM_THEME.primaryColor,
        child: child,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32))
    ),
        
    ),
  );
}

Future<void> showAlert({BuildContext context ,String title, String content}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title , style: TextStyle(color: Colors.white),),
        backgroundColor: CustomTheme.CUSTOM_THEME.primaryColor,
        content:  Text(content , style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          FlatButton(
            child: Text('OK' , style: TextStyle(color: Colors.white , fontSize: 16),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}