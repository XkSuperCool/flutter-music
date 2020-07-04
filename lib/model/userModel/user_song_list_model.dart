// To parse this JSON data, do
//
//     final userSongListModel = userSongListModelFromJson(jsonString);

import 'dart:convert';

UserSongListModel userSongListModelFromJson(String str) => UserSongListModel.fromJson(json.decode(str));

String userSongListModelToJson(UserSongListModel data) => json.encode(data.toJson());

class UserSongListModel {
  UserSongListModel({
    this.name,
    this.coverImgUrl,
    this.trackCount,
    this.userId,
    this.id,
  });

  String name;
  String coverImgUrl;
  int trackCount;
  int userId;
  int id;

  factory UserSongListModel.fromJson(Map<String, dynamic> json) => UserSongListModel(
    name: json["name"],
    coverImgUrl: json["coverImgUrl"],
    trackCount: json["trackCount"],
    userId: json["userId"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "coverImgUrl": coverImgUrl,
    "trackCount": trackCount,
    "userId": userId,
    "id": id,
  };
}
