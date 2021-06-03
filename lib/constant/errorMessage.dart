import 'package:flutter/material.dart';

class ErrorMessage {
  static showSnackMessage({@required String message}) {
    return SnackBar(
      elevation: 5,
      duration: Duration(seconds: 3),
      content: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
