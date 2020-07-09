// To parse this JSON data, do
//
//     final userAttentionModel = userAttentionModelFromJson(jsonString);

import 'dart:convert';

UserAttentionModel userAttentionModelFromJson(String str) => UserAttentionModel.fromJson(json.decode(str));

String userAttentionModelToJson(UserAttentionModel data) => json.encode(data.toJson());

class UserAttentionModel {
  UserAttentionModel({
    this.py,
    this.time,
    this.userId,
    this.vipType,
    this.remarkName,
    this.follows,
    this.followeds,
    this.avatarUrl,
    this.authStatus,
    this.userType,
    this.gender,
    this.expertTags,
    this.experts,
    this.mutual,
    this.accountStatus,
    this.nickname,
    this.followed,
    this.signature,
    this.blacklist,
    this.eventCount,
    this.playlistCount,
  });

  String py;
  int time;
  int userId;
  int vipType;
  dynamic remarkName;
  int follows;
  int followeds;
  String avatarUrl;
  int authStatus;
  int userType;
  int gender;
  dynamic expertTags;
  dynamic experts;
  bool mutual;
  int accountStatus;
  String nickname;
  bool followed;
  String signature;
  bool blacklist;
  int eventCount;
  int playlistCount;

  factory UserAttentionModel.fromJson(Map<String, dynamic> json) => UserAttentionModel(
    py: json["py"],
    time: json["time"],
    userId: json["userId"],
    vipType: json["vipType"],
    remarkName: json["remarkName"],
    follows: json["follows"],
    followeds: json["followeds"],
    avatarUrl: json["avatarUrl"],
    authStatus: json["authStatus"],
    userType: json["userType"],
    gender: json["gender"],
    expertTags: json["expertTags"],
    experts: json["experts"],
    mutual: json["mutual"],
    accountStatus: json["accountStatus"],
    nickname: json["nickname"],
    followed: json["followed"],
    signature: json["signature"],
    blacklist: json["blacklist"],
    eventCount: json["eventCount"],
    playlistCount: json["playlistCount"],
  );

  Map<String, dynamic> toJson() => {
    "py": py,
    "time": time,
    "userId": userId,
    "vipType": vipType,
    "remarkName": remarkName,
    "follows": follows,
    "followeds": followeds,
    "avatarUrl": avatarUrl,
    "authStatus": authStatus,
    "userType": userType,
    "gender": gender,
    "expertTags": expertTags,
    "experts": experts,
    "mutual": mutual,
    "accountStatus": accountStatus,
    "nickname": nickname,
    "followed": followed,
    "signature": signature,
    "blacklist": blacklist,
    "eventCount": eventCount,
    "playlistCount": playlistCount,
  };
}

class Associator {
  Associator({
    this.vipCode,
    this.rights,
  });

  int vipCode;
  bool rights;

  factory Associator.fromJson(Map<String, dynamic> json) => Associator(
    vipCode: json["vipCode"],
    rights: json["rights"],
  );

  Map<String, dynamic> toJson() => {
    "vipCode": vipCode,
    "rights": rights,
  };
}
