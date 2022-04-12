import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdab_jomreang/utils/Constant.dart';
import 'package:sdab_jomreang/views/AddMusicPage.dart';
import 'package:sdab_jomreang/views/MusicPlayerPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => MusicPlayerPage());
            },
            icon: Icon(Icons.music_note),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => AddMusicPage());
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.only(left: 8),
            title: Text("Out Of Time $index"),
            subtitle: Text("The Weekends"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: ExtendedImage.network(
                dummyNetworkImage,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                enableLoadState: true,
                // enableMemoryCache: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
