import 'dart:convert';

SongListModel songListModelFromJson(String str) => SongListModel.fromJson(json.decode(str));

String songListModelToJson(SongListModel data) => json.encode(data.toJson());

class SongListModel {
  SongListModel({
    this.id,
    this.type,
    this.name,
    this.copywriter,
    this.picUrl,
    this.canDislike,
    this.trackNumberUpdateTime,
    this.playCount,
    this.trackCount,
    this.highQuality,
    this.alg,
    this.updateTime
  });

  int id;
  int type;
  String name;
  String copywriter;
  String picUrl;
  bool canDislike;
  int trackNumberUpdateTime;
  int playCount;
  int trackCount;
  bool highQuality;
  String alg;
  int updateTime;

  factory SongListModel.fromJson(Map<String, dynamic> json) => SongListModel(
    id: json["id"],
    name: json["name"],
    picUrl: json["picUrl"],
    playCount: json["playCount"],
    updateTime: json['updateTime'] ?? 0
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "name": name,
    "copywriter": copywriter,
    "picUrl": picUrl,
    "canDislike": canDislike,
    "trackNumberUpdateTime": trackNumberUpdateTime,
    "playCount": playCount,
    "trackCount": trackCount,
    "highQuality": highQuality,
    "alg": alg,
  };
}
