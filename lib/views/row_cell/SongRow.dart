import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdab_jomreang/controllers/MusicPlayerController.dart';
import 'package:sdab_jomreang/models/Song.dart';
import 'package:sdab_jomreang/utils/Constant.dart';
import 'package:sdab_jomreang/views/MusicPlayerPage.dart';

class SongRow extends StatefulWidget {
  const SongRow({
    Key? key,
    required this.song,
    required this.onTap,
  }) : super(key: key);

  final Song song;
  final Future<void> Function()  onTap;

  @override
  State<SongRow> createState() => _SongRowState();
}

class _SongRowState extends State<SongRow> {
  bool isLoading = false;
  final musicController = Get.find<MusicPlayerController>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        // setState(() => isLoading = true);
        // if (widget.song.musicFileUrl != null) {
        //   await musicController.setCurrentSong(widget.song);
        //   Get.to(() => MusicPlayerPage());
        // }
        // setState(() => isLoading = false);
      },
      contentPadding: EdgeInsets.only(left: 8),
      title: Text(widget.song.trackName ?? ""),
      subtitle: Text(
        formatTrackArtists(widget.song.trackArtistNames ?? []),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: (isLoading)
            ? CircularProgressIndicator()
            : Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: ExtendedImage.network(
          widget.song.artworkFileUrl ?? dummyNetworkImage,
          height: 60,
          width: 60,
          fit: BoxFit.cover,
          enableLoadState: true,
          clearMemoryCacheIfFailed: true,
          timeLimit: Duration(milliseconds: 3600),
        ),
      ),
    );
  }
}
