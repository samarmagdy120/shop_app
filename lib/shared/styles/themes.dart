import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'colors.dart';

ThemeData darkTheme = ThemeData(
    primarySwatch: defaultColor,
    fontFamily: 'Jannah',
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      unselectedLabelStyle: TextStyle(color: Colors.grey),
      elevation: 20,
      backgroundColor: HexColor('333739'),
    ),
    appBarTheme: AppBarTheme(
        titleSpacing: 20.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor('333739'),
            statusBarIconBrightness: Brightness.light),
        backgroundColor: HexColor('333739'),
        elevation: 0,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.white)));

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: defaultColor,
    fontFamily: 'Jannah',
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        elevation: 20,
        backgroundColor: HexColor('333739')),
    appBarTheme: AppBarTheme(
        backwardsCompatibility: false,
        titleSpacing: 20.0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black)));
