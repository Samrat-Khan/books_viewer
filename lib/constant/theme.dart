import 'package:flutter/material.dart';

class Customtheme {
  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: Color(0xff191835),
      backgroundColor: Color(0xff191835),
      textTheme: ThemeData.dark().textTheme,
      accentColor: Color(0xff6f68fd),
      primaryColor: Color(0xff191835),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xff6f68fd),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      ),
    );
  }
}
