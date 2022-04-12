import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:sdab_jomreang/models/Music.dart';
import 'package:sdab_jomreang/utils/Constant.dart';

class MusicService {
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;

  ///POST
  Future<void> addMusic(PlatformFile file) async {
    late final Metadata metadata;
    if (kIsWeb) {
      metadata = await MetadataRetriever.fromBytes(file.bytes!);
    } else {
      metadata = await MetadataRetriever.fromFile(File(file.path!));
    }
    final String? musicFileUrl = await uploadMusicFile(metadata);
    final String? artworkUrl = await uploadArtwork(metadata);
    if (musicFileUrl == null) {
      return;
    }
    final music = Music(
      trackName: metadata.trackName,
      trackArtistNames: metadata.trackArtistNames,
      albumName: metadata.albumName,
      albumArtistName: metadata.albumArtistName,
      year: metadata.year,
      genre: metadata.genre,
      mimeType: metadata.mimeType,
      filePath: metadata.filePath,
      musicFileUrl: musicFileUrl,
      artworkFileUrl: artworkUrl,
    );
    await uploadMusicData(music);
  }

  Future<String?> uploadMusicFile(Metadata file) async {
    try {
      final musicFilename = "${DateTime.now()} - ${file.trackName}";
      final musicStorageRef = storage.ref('music/').child(musicFilename);

      if (file.filePath != null) {
        await musicStorageRef.putFile(File(file.filePath!));
      }
      final musicFileUrl = await musicStorageRef.getDownloadURL();
      return musicFileUrl;
    } on FirebaseException catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<String?> uploadArtwork(Metadata file) async {
    try {
      final artworkFilename = "${DateTime.now()} - ${file.albumName}";
      final artworkStorageRef = storage.ref('artwork/').child(artworkFilename);

      if (file.albumArt != null) {
        await artworkStorageRef.putData(file.albumArt!);
      }
      final artworkUrl = await artworkStorageRef.getDownloadURL();
      return artworkUrl;
    } on FirebaseException catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<DocumentReference> uploadMusicData(Music music) async {
    return await db.collection("music").add(music.toMap());
  }

  ///GET
  Future<List<Music>?> getMusics() async {
    try {
      final querySnapshot = await db.collection(musicCollection).get();
      return querySnapshot.docs.map((e) => Music.fromMap(e.data())).toList();
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
