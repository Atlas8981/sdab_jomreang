import 'dart:convert';

Music musicFromMap(String str) => Music.fromMap(json.decode(str));

String musicToMap(Music data) => json.encode(data.toMap());

class Music {
  Music({
    required this.trackName,
    required this.trackArtistNames,
    required this.albumName,
    required this.albumArtistName,
    required this.year,
    required this.genre,
    required this.mimeType,
    required this.filePath,
    required this.musicFileUrl,
    required this.artworkFileUrl,
  });

  String? trackName;
  List<String>? trackArtistNames;
  String? albumName;
  String? albumArtistName;
  dynamic year;
  dynamic genre;
  String? mimeType;
  String? filePath;
  String? musicFileUrl;
  String? artworkFileUrl;

  factory Music.fromMap(Map<String, dynamic> json) => Music(
        trackName: json["trackName"],
        trackArtistNames:
            List<String>.from(json["trackArtistNames"].map((x) => x)),
        albumName: json["albumName"],
        albumArtistName: json["albumArtistName"],
        year: json["year"],
        genre: json["genre"],
        mimeType: json["mimeType"],
        filePath: json["filePath"],
        musicFileUrl: json["musicFileUrl"],
        artworkFileUrl: json["artworkFile"],
      );

  Map<String, dynamic> toMap() => {
        "trackName": trackName,
        "trackArtistNames":
            List<String>.from(trackArtistNames?.map((x) => x) ?? []),
        "albumName": albumName,
        "albumArtistName": albumArtistName,
        "year": year,
        "genre": genre,
        "mimeType": mimeType,
        "filePath": filePath,
        "musicFileUrl": musicFileUrl,
        "artworkFile": artworkFileUrl,
      };
}
