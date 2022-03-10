import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sdab_jomreang/components/ImageViews.dart';
import 'package:sdab_jomreang/models/image.dart' as image;
import 'package:sdab_jomreang/utils/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final player = AudioPlayer();

  double sliderValue = 0;

  final images = [
    image.Image(imageName: "imageName", imageUrl: dummyNetworkImage),
  ];

  Future<void> something() async {
    var duration = await player.setAsset("assets/music/merrychristmas.mp3");
    print(duration);
  }

  @override
  Future<void> initState() async {
    super.initState();
    player.playerStateStream.listen((event) {
      print(event.processingState);
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
        child: ImageView(
          displayImage: images[0],
        ),
      ),
    );
  }

  Widget bottomControlls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {},
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
            something();
          },
          icon: Icon(
            Icons.play_circle_filled,
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

  Widget musicSlider() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 24, right: 24, top: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("00:00"),
              Text("00:00"),
            ],
          ),
        ),
        Slider(
          value: sliderValue,
          min: 0,
          max: 100,
          onChanged: (double value) {
            setState(() {
              sliderValue = value;
            });
          },
        ),
      ],
    );
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
          onPressed: () {},
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
          // crossAxisAlignment: CrossAxisAlignment.start,
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
                bottomControlls(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
