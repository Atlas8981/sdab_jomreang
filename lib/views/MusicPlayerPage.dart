import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sdab_jomreang/models/Image.dart' as image;
import 'package:sdab_jomreang/utils/Constant.dart';

class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  final player = AudioPlayer();
  Duration? duration;
  double sliderValue = 0;

  final images = [
    image.Image(
      imageName: "imageName",
      imageUrl: dummyNetworkImage,
    ),
  ];

  Future<void> setTrack() async {
    duration = await player.setAsset("assets/music/merrychristmas.mp3");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setTrack();
    player.playerStateStream.listen((event) {
      switch (event.processingState) {
        case ProcessingState.idle:
          // TODO: Handle this case.
          break;
        case ProcessingState.loading:
          // TODO: Handle this case.
          break;
        case ProcessingState.buffering:
          // TODO: Handle this case.
          break;
        case ProcessingState.ready:
          // TODO: Handle this case.
          break;
        case ProcessingState.completed:
          // TODO: Handle this case.
          break;
      }
    });
  }

  Widget songImageView() {
    return Padding(
      padding: EdgeInsets.all(48),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        child: ExtendedImage.network(
          images[0].imageUrl,
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
          handleLoadingProgress: true,
        ),
      ),
    );
  }

  Widget bottomControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            player.stop();
          },
          icon: Icon(
            Icons.shuffle,
          ),
          iconSize: 32,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.skip_previous,
          ),
          iconSize: 36,
        ),
        IconButton(
          onPressed: () {
            if (player.playing) {
              player.pause();
            } else {
              player.play();
            }
            setState(() {});
          },
          icon: Icon(
            (player.playing) ? Icons.pause : Icons.play_circle_filled,
          ),
          padding: EdgeInsets.all(0),
          iconSize: 76,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.skip_next,
          ),
          iconSize: 36,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.repeat,
          ),
          iconSize: 32,
        ),
      ],
    );
  }

  bool isTimerEnd = false;
  bool isNotSliding = true;

  Widget musicSlider() {
    return StreamBuilder<Duration>(
      stream: player.positionStream,
      builder: (context, snapshot) {
        final int endTime = DateTime.now().millisecondsSinceEpoch +
            (duration?.inMilliseconds ?? 0);
        if (isNotSliding) {
          sliderValue = snapshot.data?.inSeconds.toDouble() ?? 0;
        }
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    durationToTimeString(snapshot.data),
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    durationToTimeString(duration),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Slider(
              value: sliderValue,
              min: 0,
              max: duration?.inSeconds.toDouble() ?? 0,
              onChangeStart: (double value) {
                setState(() {
                  isNotSliding = false;
                });
              },
              onChangeEnd: (double value) {
                player.seek(
                  Duration(seconds: value.toInt()),
                );
                setState(() {
                  isNotSliding = true;
                });
              },
              onChanged: (double value) {
                setState(() {
                  sliderValue = value;
                });
              },
            ),
          ],
        );
      },
    );
  }

  String durationToTimeString(Duration? duration) {
    if (duration == null) {
      return "00:00";
    }
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  String remainingTimeToTimeString(CurrentRemainingTime? duration) {
    if (duration == null) {
      return "00:00";
    }
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.min!.remainder(60));
    String twoDigitSeconds = twoDigits(duration.sec!.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget musicTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Out Of Time",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text("The Weekends"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: RotatedBox(
            quarterTurns: 1,
            child: Icon(
              Icons.chevron_right,
              size: 32,
            ),
          ),
        ),
        title: Text(
          "Newly Discover",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            songImageView(),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          musicTitle(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                musicSlider(),
                bottomControls(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
