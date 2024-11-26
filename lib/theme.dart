import 'package:flutter/material.dart';

class ThemeClass {
  Color lightPrimaryColor = Colors.blue;
  Color darkPrimaryColor = Colors.black;
  Color secondaryColor = Colors.yellow;
  Color accentColor = Colors.green;

  static ThemeData lightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light(primary: Colors.blue,
          secondary: Colors.green,
          background: Colors.white,
          surface:Colors.grey),);

  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.dark(primary: Colors.blue,
          secondary: Colors.green,
          background: Colors.black,
          surface: Colors.grey,
        ),
  );
}

ThemeClass _themeClass = ThemeClass();