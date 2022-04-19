import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sdab_jomreang/controllers/MusicPlayerController.dart';
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
  final player = Get.find<MusicPlayerController>().player;
  final currentSong = Get.find<MusicPlayerController>().currentSong;
  final musicController = Get.find<MusicPlayerController>();
  Duration? duration;
  double sliderValue = 0;
  bool isTimerEnd = false;
  bool isNotSliding = true;

  @override
  void initState() {
    super.initState();
    duration = player.duration;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "(Newly Discover)",
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

  Widget songImageView() {
    return Padding(
      padding: EdgeInsets.all(48),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        child: GetBuilder<MusicPlayerController>(
          builder: (controller) {
            return ExtendedImage.network(
              controller.currentSong?.artworkFileUrl ?? "",
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              handleLoadingProgress: true,
              loadStateChanged: (state) {
                if (state.extendedImageLoadState == LoadState.failed) {
                  return ExtendedImage.network(
                    dummyNetworkImage,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                    handleLoadingProgress: true,
                  );
                }
                return null;
              },
            );
          },
        ),
      ),
    );
  }

  Widget musicTitle() {
    return GetBuilder<MusicPlayerController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.currentSong?.trackName ?? "",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(formatTrackArtists(controller.currentSong?.trackArtistNames ?? [])),
          ],
        );
      },
    );
  }

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

  Widget bottomControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            player.setShuffleModeEnabled(!player.shuffleModeEnabled);
            setState(() {});
          },
          icon: Icon(
            (player.shuffleModeEnabled)
                ? Icons.shuffle_on_outlined
                : Icons.shuffle,
          ),
          iconSize: 32,
        ),
        IconButton(
          onPressed: () async {
            musicController.previousSong();
          },
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
          onPressed: () async {
            musicController.nextSong();
          },
          icon: Icon(
            Icons.skip_next,
          ),
          iconSize: 36,
        ),
        StreamBuilder<LoopMode>(
          stream: player.loopModeStream,
          builder: (context, snapshot) {
            final currentLoopMode = snapshot.data ?? LoopMode.off;
            LoopMode? nextLoopMode;
            switch (currentLoopMode) {
              case LoopMode.off:
                nextLoopMode = LoopMode.all;
                break;
              case LoopMode.all:
                nextLoopMode = LoopMode.one;
                break;
              case LoopMode.one:
                nextLoopMode = LoopMode.off;
                break;
              default:
                nextLoopMode = LoopMode.one;
                break;
            }

            return IconButton(
              onPressed: () async {
                await player.setLoopMode(nextLoopMode ?? LoopMode.off);
                setState(() {});
              },
              icon: Icon(
                determineRepeatIcon(currentLoopMode),
              ),
              iconSize: 32,
            );
          },
        ),
      ],
    );
  }

  IconData determineRepeatIcon(LoopMode loopMode) {
    switch (loopMode) {
      case LoopMode.off:
        return Icons.repeat;
      case LoopMode.one:
        return Icons.repeat_one_on_outlined;
      case LoopMode.all:
        return Icons.repeat_on_outlined;
    }
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
}
