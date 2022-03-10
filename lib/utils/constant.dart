
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

const String imageDir = "assets/images/";

final redColor = Color.fromARGB(255, 236, 0, 0);

const String dummyNetworkImage =
    "https://firebasestorage.googleapis.com/v0/b/mygoods-e042f.appspot.com/o/flutter%2F2021-10-31%2021%3A58%3A15.282499?alt=media&token=f492b829-e106-467e-b3f1-6c05122a0969";

String? validatePhoneNumber(String? value) {
  String pattern = r'^(?:[+0][1-9])?[0-9]{9,10}$';
  RegExp regExp = RegExp(pattern);

  if (value == null || value.isEmpty) {
    return 'Empty Field';
  } else if (!regExp.hasMatch("0" + value)) {
    return 'Incorrect Phone Format';
  }
  return null;
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    fontSize: 18,
    backgroundColor: Colors.blue,
    textColor: Colors.white,
  );
}

void showSnackBar(String title, String message) {
  Get.snackbar(
    title,
    message,
  );
}
