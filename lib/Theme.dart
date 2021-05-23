import 'package:flutter/material.dart';

class AppTheme {

  AppTheme._();

  static const Color primaryColor = Color(0xFF1DA1F3);
  static const Color primaryTextColor = Colors.black;
  static const Color grey1 = Color(0xFF5F738C);
  static const Color grey2 = Color(0xFF89959B);

  static final ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFFFCFCFC),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: primaryColor,
  ),
    textTheme: appTextTheme,
  );

  static final TextTheme appTextTheme = TextTheme(
    headline1: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
      fontSize: 20.0,
      color: primaryTextColor,
    ),
    headline2: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
      fontSize: 16.0,
      color: primaryTextColor,
    ),
    headline3: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      color: primaryTextColor,
    ),
    bodyText1: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      color: grey1,
      height: 1.5,
    ),
    bodyText2: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      color: grey2,
      height: 1.5,
    ),
  );
}