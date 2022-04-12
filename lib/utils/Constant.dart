import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

const String imageDir = "assets/images/";
const String userCollection = "users";
const String itemCollection = "items";
const String additionalCollection = "additionInfo";
const String saveItemCollection = "saveItems";
const String recentViewItemCollection = "recentView";

final redColor = Color.fromARGB(255, 236, 0, 0);

const String dummyNetworkImage =
    "https://th.bing.com/th/id/R.7ca608e41bd6e2688a4f82e356d63af3?rik=fmRH9n%2f9G6wKqg&pid=ImgRaw&r=0";

const String networkBackgroundImage =
    "https://firebasestorage.googleapis.com/v0/b/project-shotgun.appspot.com/o/IMG_2086-EFFECTS.jpg?alt=media&token=fcd87303-09e6-4ec7-9620-211f240fc85f";

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

String getFont() {
  if (Get.locale == const Locale('en', 'US')) {
    return 'Roboto';
  } else {
    return 'KhmerOSBattambang';
  }
}

ThemeMode determineThemeMode(String? selectedMode) {
  if (selectedMode == "Light") {
    return ThemeMode.light;
  } else if (selectedMode == "Dark") {
    return ThemeMode.dark;
  } else {
    return ThemeMode.system;
  }
}
