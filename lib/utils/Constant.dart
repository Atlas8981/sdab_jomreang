import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

const String imageDir = "assets/images/";
const String userCollection = "users";
const String musicCollection = "music";
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

final time = DateFormat('mm:ss');

String formatDateTimeFromInt(int? millisecond) {
  if (millisecond == null) {
    return "";
  }

  final asDateTime = DateTime.fromMillisecondsSinceEpoch(millisecond);
  final timeAsString = time.format(asDateTime);
  return timeAsString;
}

String calDate(int? millisecond) {
  if (millisecond == null) {
    return "00:00";
  }
  //millisecond to second
  int amountOfTime = millisecond / 1000 as int;
  String timeEnd = " seconds";
  if (amountOfTime > 60) {
    amountOfTime = amountOfTime / 60 as int;
    timeEnd = " minutes";
  }

  return "$amountOfTime" + timeEnd;
}

String formatTrackArtists (List<String> artists){
  if(artists.isEmpty){
    return "";
  }
  String result = "";
  for (String element in artists) {
    result = result + " $element";
  }
  return result;
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
