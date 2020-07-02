import 'dart:convert';

LyricsModel lyricsModelFromJson(String str) => LyricsModel.fromJson(json.decode(str));

String lyricsModelToJson(LyricsModel data) => json.encode(data.toJson());

class LyricsModel {
  LyricsModel({
    this.version,
    this.lyric,
  });

  int version;
  String lyric;

  factory LyricsModel.fromJson(Map<String, dynamic> json) => LyricsModel(
    version: json["version"],
    lyric: json["lyric"],
  );

  Map<String, dynamic> toJson() => {
    "version": version,
    "lyric": lyric,
  };
}
