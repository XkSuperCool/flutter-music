import 'dart:convert';

RecommendMusicModel RecommendMusicModelFromJson(String str) => RecommendMusicModel.fromJson(json.decode(str));

String RecommendMusicModelToJson(RecommendMusicModel data) => json.encode(data.toJson());

class RecommendMusicModel {
  RecommendMusicModel({
    this.id,
    this.type,
    this.name,
    this.picUrl,
    this.song,
  });

  int id;
  int type;
  String name;
  String picUrl;
  Song song;

  factory RecommendMusicModel.fromJson(Map<String, dynamic> json) => RecommendMusicModel(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    picUrl: json["picUrl"],
    song: Song.fromJson(json["song"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "name": name,
    "picUrl": picUrl,
    "song": song.toJson(),
  };
}

class Song {
  Song({
    this.artists,
    this.duration
  });

  List<Artist> artists;
  int duration;

  factory Song.fromJson(Map<String, dynamic> json) => Song(
      artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
      duration: json['duration']
  );

  Map<String, dynamic> toJson() => {
    "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
  };
}

class Artist {
  Artist({
    this.name,
    this.id,
    this.picId,
    this.img1V1Id,
    this.briefDesc,
    this.picUrl,
    this.img1V1Url,
    this.albumSize,
    this.alias,
    this.trans,
    this.musicSize,
    this.topicPerson,
  });

  String name;
  int id;
  int picId;
  int img1V1Id;
  String briefDesc;
  String picUrl;
  String img1V1Url;
  int albumSize;
  List<dynamic> alias;
  String trans;
  int musicSize;
  int topicPerson;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    name: json["name"],
    id: json["id"],
    picId: json["picId"],
    img1V1Id: json["img1v1Id"],
    briefDesc: json["briefDesc"],
    picUrl: json["picUrl"],
    img1V1Url: json["img1v1Url"],
    albumSize: json["albumSize"],
    alias: List<dynamic>.from(json["alias"].map((x) => x)),
    trans: json["trans"],
    musicSize: json["musicSize"],
    topicPerson: json["topicPerson"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "picId": picId,
    "img1v1Id": img1V1Id,
    "briefDesc": briefDesc,
    "picUrl": picUrl,
    "img1v1Url": img1V1Url,
    "albumSize": albumSize,
    "alias": List<dynamic>.from(alias.map((x) => x)),
    "trans": trans,
    "musicSize": musicSize,
    "topicPerson": topicPerson,
  };
}
