import 'package:flutter/material.dart';

class Utils {
  ToastMessage(String title, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      content: Text(title),
      backgroundColor: Colors.red,
    ));
  }
}
