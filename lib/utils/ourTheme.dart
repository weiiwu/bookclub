import 'package:flutter/material.dart';

class OurTheme {
  Color _lightBlue = Color.fromARGB(255, 194, 237, 255);
  Color _lightGrey = Color.fromARGB(255, 164, 164, 164);
  Color _darkGrey = Color.fromARGB(255, 119, 124, 135);

  ThemeData buildTheme() {
    return ThemeData(
      canvasColor: _lightBlue,
      primaryColor: _lightBlue,
      accentColor: _lightGrey,
      secondaryHeaderColor: _darkGrey,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: _lightGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: _lightBlue,
          ),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: _darkGrey,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        minWidth: 200,
        height: 40.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
