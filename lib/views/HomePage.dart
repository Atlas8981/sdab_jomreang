import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdab_jomreang/components/CustomErrorWidget.dart';
import 'package:sdab_jomreang/components/LoadingWidget.dart';
import 'package:sdab_jomreang/models/Music.dart';
import 'package:sdab_jomreang/services/MusicService.dart';
import 'package:sdab_jomreang/utils/Constant.dart';
import 'package:sdab_jomreang/views/AddMusicPage.dart';
import 'package:sdab_jomreang/views/MusicPlayerPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final musicService = MusicService();

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
      body: FutureBuilder<List<Music>?>(
        future: musicService.getMusics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return CustomErrorWidget();
          }
          final List<Music> songs = snapshot.data ?? [];
          if (songs.isEmpty) {
            return CustomErrorWidget(
              text: "No Songs",
            );
          }
          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final currentSong = songs[index];
              return ListTile(
                onTap: () {

                },
                contentPadding: EdgeInsets.only(left: 8),
                title: Text(currentSong.trackName ?? ""),
                subtitle: Text(
                  formatTrackArtists(currentSong.trackArtistNames ?? []),
                ),
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
                    currentSong.artworkFileUrl ?? dummyNetworkImage,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                    enableLoadState: true,
                    clearMemoryCacheIfFailed: true,
                    timeLimit: Duration(milliseconds: 3600),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
