// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.profile,
    this.token,
    this.cookie,
    this.code,
  });

  Profile profile;
  String token;
  String cookie;
  int code;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    profile: Profile.fromJson(json["profile"]),
    token: json["token"],
    cookie: json["cookie"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "profile": profile.toJson(),
    "token": token,
    "cookie": cookie,
    "code": code,
  };
}

class Profile {
  Profile({
    this.mutual,
    this.remarkName,
    this.expertTags,
    this.authStatus,
    this.djStatus,
    this.experts,
    this.avatarImgId,
    this.nickname,
    this.birthday,
    this.city,
    this.userType,
    this.backgroundImgId,
    this.avatarUrl,
    this.province,
    this.defaultAvatar,
    this.vipType,
    this.gender,
    this.accountStatus,
    this.detailDescription,
    this.followed,
    this.backgroundUrl,
    this.backgroundImgIdStr,
    this.description,
    this.userId,
    this.avatarImgIdStr,
    this.signature,
    this.authority,
    this.profileAvatarImgIdStr,
    this.followeds,
    this.follows,
    this.eventCount,
    this.playlistCount,
    this.playlistBeSubscribedCount,
  });

  bool mutual;
  dynamic remarkName;
  dynamic expertTags;
  int authStatus;
  int djStatus;
  Experts experts;
  double avatarImgId;
  String nickname;
  int birthday;
  int city;
  int userType;
  double backgroundImgId;
  String avatarUrl;
  int province;
  bool defaultAvatar;
  int vipType;
  int gender;
  int accountStatus;
  String detailDescription;
  bool followed;
  String backgroundUrl;
  String backgroundImgIdStr;
  String description;
  int userId;
  String avatarImgIdStr;
  String signature;
  int authority;
  String profileAvatarImgIdStr;
  int followeds;
  int follows;
  int eventCount;
  int playlistCount;
  int playlistBeSubscribedCount;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    mutual: json["mutual"],
    remarkName: json["remarkName"],
    expertTags: json["expertTags"],
    authStatus: json["authStatus"],
    djStatus: json["djStatus"],
    experts: Experts.fromJson(json["experts"]),
    avatarImgId: json["avatarImgId"].toDouble(),
    nickname: json["nickname"],
    birthday: json["birthday"],
    city: json["city"],
    userType: json["userType"],
    backgroundImgId: json["backgroundImgId"].toDouble(),
    avatarUrl: json["avatarUrl"],
    province: json["province"],
    defaultAvatar: json["defaultAvatar"],
    vipType: json["vipType"],
    gender: json["gender"],
    accountStatus: json["accountStatus"],
    detailDescription: json["detailDescription"],
    followed: json["followed"],
    backgroundUrl: json["backgroundUrl"],
    backgroundImgIdStr: json["backgroundImgIdStr"],
    description: json["description"],
    userId: json["userId"],
    avatarImgIdStr: json["avatarImgIdStr"],
    signature: json["signature"],
    authority: json["authority"],
    profileAvatarImgIdStr: json["avatarImgId_str"],
    followeds: json["followeds"],
    follows: json["follows"],
    eventCount: json["eventCount"],
    playlistCount: json["playlistCount"],
    playlistBeSubscribedCount: json["playlistBeSubscribedCount"],
  );

  Map<String, dynamic> toJson() => {
    "mutual": mutual,
    "remarkName": remarkName,
    "expertTags": expertTags,
    "authStatus": authStatus,
    "djStatus": djStatus,
    "experts": experts.toJson(),
    "avatarImgId": avatarImgId,
    "nickname": nickname,
    "birthday": birthday,
    "city": city,
    "userType": userType,
    "backgroundImgId": backgroundImgId,
    "avatarUrl": avatarUrl,
    "province": province,
    "defaultAvatar": defaultAvatar,
    "vipType": vipType,
    "gender": gender,
    "accountStatus": accountStatus,
    "detailDescription": detailDescription,
    "followed": followed,
    "backgroundUrl": backgroundUrl,
    "backgroundImgIdStr": backgroundImgIdStr,
    "description": description,
    "userId": userId,
    "avatarImgIdStr": avatarImgIdStr,
    "signature": signature,
    "authority": authority,
    "avatarImgId_str": profileAvatarImgIdStr,
    "followeds": followeds,
    "follows": follows,
    "eventCount": eventCount,
    "playlistCount": playlistCount,
    "playlistBeSubscribedCount": playlistBeSubscribedCount,
  };
}

class Experts {
  Experts();

  factory Experts.fromJson(Map<String, dynamic> json) => Experts(
  );

  Map<String, dynamic> toJson() => {
  };
}
