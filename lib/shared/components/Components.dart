
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layouts/login/LoginScreen.dart';
import 'package:shop_app/shared/networks/local/cash_helper.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

/*****************/
void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

/*********************/
Widget defaultButton(
        {double width = double.infinity,
        Color background = Colors.blue,
        required VoidCallback function,
        required String text,
        bool isUpperCase: true}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

/************************************/

Widget defaultTextButton(
        {required VoidCallback function, required String text}) =>
    TextButton(
        onPressed:(){
          function();
          }
    , child: Text(text.toUpperCase()));

/***************************/

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        ValueChanged? onSubmit,
        ValueChanged? onChange,
        required FormFieldValidator validate,
        required String label,
        IconData? suffix,
        required IconData prefix,
        VoidCallback? suffixPressed,
        isPassword = false}) =>
    TextFormField(
      // 3lshan a7'd ali gwah
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,

      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(
                  suffix,
                ),
                onPressed: suffixPressed,
              )
            : null,
        border: OutlineInputBorder(),
      ),
      validator: validate,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
    );

/*********************************/
void showToast({required String text,required ToastStates state}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

// enum

enum ToastStates {SUCCESS, ERROR, WARNING}

Color? chooseToastColor(ToastStates state){
  Color? color;

  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
      case ToastStates.WARNING:
    color = Colors.amber;
    break;

  }
  return color;
}

/*********/

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if(value){
      navigateAndFinish(context, LoginScreen());
    }
  });
}

/***************************/

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);