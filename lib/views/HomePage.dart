import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sdab_jomreang/components/CustomErrorWidget.dart';
import 'package:sdab_jomreang/components/LoadingWidget.dart';
import 'package:sdab_jomreang/controllers/MusicPlayerController.dart';
import 'package:sdab_jomreang/models/Song.dart';
import 'package:sdab_jomreang/services/MusicService.dart';
import 'package:sdab_jomreang/utils/Constant.dart';
import 'package:sdab_jomreang/views/AddMusicPage.dart';
import 'package:sdab_jomreang/views/MusicPlayerPage.dart';
import 'package:sdab_jomreang/views/row_cell/SongRow.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final musicService = MusicService();
  final musicController = Get.find<MusicPlayerController>();
  final player = Get.find<MusicPlayerController>().player;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Scaffold(
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
        body: FutureBuilder<List<Song>?>(
          future: musicService.getMusics(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingWidget();
            }
            if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data == null) {
              return CustomErrorWidget();
            }
            final List<Song> songs = snapshot.data ?? [];
            if (songs.isEmpty) {
              return CustomErrorWidget(
                text: "No Songs",
              );
            }

            musicController.setPlaylist(songs);

            return ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final currentSong = songs[index];
                return SongRow(
                  song: currentSong,
                  onTap: () async {

                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
