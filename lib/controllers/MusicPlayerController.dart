import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sdab_jomreang/models/Music.dart';

class MusicPlayerController extends GetxController {
  final player = AudioPlayer();
  Music? currentSong;
  RxBool isLoading = false.obs;

  Future<void> setCurrentSong(Music music) async {
    if (music.musicFileUrl != null) {
      isLoading.value = true;
      await player.setUrl(music.musicFileUrl!);
      currentSong = music;
    }
    isLoading.value = false;
    update();
  }
}
