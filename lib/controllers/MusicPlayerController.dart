import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sdab_jomreang/models/Song.dart';

class MusicPlayerController extends GetxController {
  final player = AudioPlayer();
  Song? currentSong;
  final List<Song> songs = [];
  ConcatenatingAudioSource? playlist;

  Future<void> previousSong() async {
    if (player.hasPrevious && player.previousIndex != null) {
      currentSong = songs[player.previousIndex!];
      update();
      await player.seekToPrevious();
    }
  }

  Future<void> nextSong() async {
    if (player.hasNext && player.nextIndex != null) {
      currentSong = songs[player.nextIndex!];
      print(currentSong.toString());
      update();
      await player.seekToNext();
    }
  }

  Future<void> setPlaylist(List<Song> newSongs) async {
    if (playlist != null) {
      return;
    }
    songs.clear();
    songs.addAll(newSongs);
    currentSong = songs[0];
    playlist = ConcatenatingAudioSource(
      children: [
        ..._generateAudioSource(songs),
      ],
    );
    if (playlist != null) {
      await player.setAudioSource(
        playlist!,
        initialIndex: 0, // default
        initialPosition: Duration.zero, // default
        preload: true, //default
      );
    }
    update();
  }

  List<AudioSource> _generateAudioSource(List<Song> songs) {
    final List<AudioSource> tempListAudioSource = [];
    for (Song s in songs) {
      if (s.musicFileUrl != null) {
        tempListAudioSource.add(AudioSource.uri(Uri.parse(s.musicFileUrl!)));
      }
    }
    return tempListAudioSource;
  }
}
