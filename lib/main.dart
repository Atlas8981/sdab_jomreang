import 'dart:io' as platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sdab_jomreang/colors/CustomColor.dart';
import 'package:sdab_jomreang/utils/InitialBinding.dart';
import 'package:sdab_jomreang/views/HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyByZyZNYC115tasIvs4rwD9hTNbKqnCir4",
        authDomain: "sdabjomreang-961c4.firebaseapp.com",
        projectId: "sdabjomreang-961c4",
        storageBucket: "sdabjomreang-961c4.appspot.com",
        messagingSenderId: "1062797921318",
        appId: "1:1062797921318:web:ea08016fa1563f7f2b2ae7",
      ),
    );
  } else if (platform.Platform.isAndroid) {
    await Firebase.initializeApp();
  }

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sdab Jomreang',
      initialBinding: InitialBinding(),
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          secondary: CutomColor.spotifyGreen,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.light(
          primary: Colors.blue,
          secondary: CutomColor.spotifyGreen,
        ),
        iconTheme: IconTheme.of(context).copyWith(
          color: Colors.white,
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}
