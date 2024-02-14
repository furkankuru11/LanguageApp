import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void ToastMessage(String message) {
  Fluttertoast.showToast(
      msg: "Minimum 4  Çift Olmalıdır",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
