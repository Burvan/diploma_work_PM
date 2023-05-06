import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DefaultTheme {
  static final ThemeData _defaultTheme = ThemeData(
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
        fontSize: 20.0,
      ),
    ),
    dialogBackgroundColor: Colors.indigo[300],
    //dialogTheme: DialogTheme()
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black45),),
    ),


  );

  static ThemeData light = _defaultTheme.copyWith(
    appBarTheme: AppBarTheme(
        color: Colors.indigo[300],
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
    primaryColor: Colors.lightBlue,
    scaffoldBackgroundColor: Colors.white,
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStatePropertyAll(Colors.black45),
    ),


  );

  static ThemeData dark = _defaultTheme.copyWith(
    appBarTheme: const AppBarTheme(
        color: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.white),
    ),
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.black,
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(Colors.indigo[300]),
      trackColor: MaterialStatePropertyAll(Colors.grey[300]),
    ),
    checkboxTheme: const CheckboxThemeData(
      fillColor: MaterialStatePropertyAll(Colors.black45),
      checkColor: MaterialStatePropertyAll(Colors.white),
    ),

  );
}
