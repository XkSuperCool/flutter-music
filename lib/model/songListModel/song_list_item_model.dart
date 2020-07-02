import 'dart:convert';

import 'package:flutter_music/model/musicProviderModel/music_item_model.dart';

SongLisItemModel songLisItemModelFromJson(String str) => SongLisItemModel.fromJson(json.decode(str));

String songLisItemModelToJson(SongLisItemModel data) => json.encode(data.toJson());

class SongLisItemModel {
  SongLisItemModel({
    this.tracks,
    this.trackIds,
    this.coverImgUrl,
    this.description,
    this.name,
    this.id,
    this.playCount,
    this.trackCount,
    this.subscribedCount,
    this.tags,
    this.creator,
    this.updateTime,
  });

  List<MusicItemModel> tracks;
  List<TrackId> trackIds;
  String coverImgUrl;
  String description;
  String name;
  int id;
  int playCount;
  int trackCount;
  int updateTime;
  int subscribedCount;
  List<String> tags;
  Creator creator;

  factory SongLisItemModel.fromJson(Map<String, dynamic> json) {
    return SongLisItemModel(
      tracks: List<MusicItemModel>.from(json["tracks"]?.map((x) => MusicItemModel.fromJson(x))),
      trackIds: List<TrackId>.from(json["trackIds"]?.map((x) => TrackId.fromJson(x))),
      coverImgUrl: json["coverImgUrl"],
      description: json["description"],
      name: json["name"],
      id: json["id"],
      playCount: json["playCount"],
      trackCount: json["trackCount"],
      subscribedCount: json["subscribedCount"],
      tags: List<String>.from(json["tags"].map((x) => x)),
      creator: Creator.fromJson(json["creator"]),
      updateTime: json["updateTime"]
    );
  }

  Map<String, dynamic> toJson() => {
    "tracks": List<dynamic>.from(tracks.map((x) => x.toJson())),
    "trackIds": List<dynamic>.from(trackIds.map((x) => x.toJson())),
    "coverImgUrl": coverImgUrl,
    "description": description,
    "name": name,
    "id": id,
    "playCount": playCount,
    "trackCount": trackCount,
    "subscribedCount": subscribedCount,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "creator": creator.toJson(),
  };
}

class Creator {
  Creator({
    this.avatarUrl,
    this.nickname,
  });

  String avatarUrl;
  String nickname;

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
    avatarUrl: json["avatarUrl"],
    nickname: json["nickname"],
  );

  Map<String, dynamic> toJson() => {
    "avatarUrl": avatarUrl,
    "nickname": nickname,
  };
}

class TrackId {
  TrackId({
    this.id,
    this.v,
    this.at,
    this.alg,
  });

  int id;
  int v;
  int at;
  String alg;

  factory TrackId.fromJson(Map<String, dynamic> json) => TrackId(
    id: json["id"],
    v: json["v"],
    at: json["at"],
    alg: json["alg"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "v": v,
    "at": at,
    "alg": alg,
  };
}

class Al {
  Al({
    this.id,
    this.name,
    this.picUrl,
    this.tns,
    this.picStr,
    this.pic,
  });

  int id;
  String name;
  String picUrl;
  List<dynamic> tns;
  String picStr;
  double pic;

  factory Al.fromJson(Map<String, dynamic> json) => Al(
    id: json["id"],
    name: json["name"],
    picUrl: json["picUrl"],
    tns: List<dynamic>.from(json["tns"].map((x) => x)),
    picStr: json["pic_str"],
    pic: json["pic"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "picUrl": picUrl,
    "tns": List<dynamic>.from(tns.map((x) => x)),
    "pic_str": picStr,
    "pic": pic,
  };
}

class Ar {
  Ar({
    this.id,
    this.name,
    this.tns,
    this.alias,
  });

  int id;
  String name;
  List<dynamic> tns;
  List<dynamic> alias;

  factory Ar.fromJson(Map<String, dynamic> json) => Ar(
    id: json["id"],
    name: json["name"],
    tns: List<dynamic>.from(json["tns"].map((x) => x)),
    alias: List<dynamic>.from(json["alias"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "tns": List<dynamic>.from(tns.map((x) => x)),
    "alias": List<dynamic>.from(alias.map((x) => x)),
  };
}

class H {
  H({
    this.br,
    this.fid,
    this.size,
    this.vd,
  });

  int br;
  int fid;
  int size;
  int vd;

  factory H.fromJson(Map<String, dynamic> json) => H(
    br: json["br"],
    fid: json["fid"],
    size: json["size"],
    vd: json["vd"],
  );

  Map<String, dynamic> toJson() => {
    "br": br,
    "fid": fid,
    "size": size,
    "vd": vd,
  };
}
