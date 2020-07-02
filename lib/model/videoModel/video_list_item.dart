// To parse this JSON data, do
//
//     final videoListItem = videoListItemFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_music/model/musicProviderModel/music_item_model.dart';

VideoListItem videoListItemFromJson(String str) => VideoListItem.fromJson(json.decode(str));

String videoListItemToJson(VideoListItem data) => json.encode(data.toJson());

class VideoListItem {
  VideoListItem({
    this.alg,
    this.scm,
    this.threadId,
    this.coverUrl,
    this.height,
    this.width,
    this.title,
    this.description,
    this.commentCount,
    this.shareCount,
    this.resolutions,
    this.creator,
    this.urlInfo,
    this.videoGroup,
    this.previewUrl,
    this.previewDurationms,
    this.hasRelatedGameAd,
    this.markTypes,
    this.relateSong,
    this.relatedInfo,
    this.videoUserLiveInfo,
    this.vid,
    this.durationms,
    this.playTime,
    this.praisedCount,
    this.praised,
    this.subscribed,
  });

  String alg;
  String scm;
  String threadId;
  String coverUrl;
  int height;
  int width;
  String title;
  String description;
  int commentCount;
  int shareCount;
  List<Resolution> resolutions;
  Creator creator;
  dynamic urlInfo;
  List<VideoGroup> videoGroup;
  String previewUrl;
  int previewDurationms;
  bool hasRelatedGameAd;
  dynamic markTypes;
  List<MusicItemModel> relateSong;
  dynamic relatedInfo;
  dynamic videoUserLiveInfo;
  String vid;
  int durationms;
  int playTime;
  int praisedCount;
  bool praised;
  bool subscribed;

  factory VideoListItem.fromJson(Map<String, dynamic> json) => VideoListItem(
    alg: json["alg"],
    scm: json["scm"],
    threadId: json["threadId"],
    coverUrl: json["coverUrl"],
    height: json["height"],
    width: json["width"],
    title: json["title"],
    description: json["description"],
    commentCount: json["commentCount"],
    shareCount: json["shareCount"],
    resolutions: List<Resolution>.from(json["resolutions"].map((x) => Resolution.fromJson(x))),
    creator: Creator.fromJson(json["creator"]),
    urlInfo: json["urlInfo"],
    videoGroup: List<VideoGroup>.from(json["videoGroup"].map((x) => VideoGroup.fromJson(x))),
    previewUrl: json["previewUrl"],
    previewDurationms: json["previewDurationms"],
    hasRelatedGameAd: json["hasRelatedGameAd"],
    markTypes: json["markTypes"],
    relateSong: List<MusicItemModel>.from(json["relateSong"].map((x) => MusicItemModel.fromJson(x))),
    relatedInfo: json["relatedInfo"],
    videoUserLiveInfo: json["videoUserLiveInfo"],
    vid: json["vid"],
    durationms: json["durationms"],
    playTime: json["playTime"],
    praisedCount: json["praisedCount"],
    praised: json["praised"],
    subscribed: json["subscribed"],
  );

  Map<String, dynamic> toJson() => {
    "alg": alg,
    "scm": scm,
    "threadId": threadId,
    "coverUrl": coverUrl,
    "height": height,
    "width": width,
    "title": title,
    "description": description,
    "commentCount": commentCount,
    "shareCount": shareCount,
    "resolutions": List<dynamic>.from(resolutions.map((x) => x.toJson())),
    "creator": creator.toJson(),
    "urlInfo": urlInfo,
    "videoGroup": List<dynamic>.from(videoGroup.map((x) => x.toJson())),
    "previewUrl": previewUrl,
    "previewDurationms": previewDurationms,
    "hasRelatedGameAd": hasRelatedGameAd,
    "markTypes": markTypes,
    "relateSong": List<dynamic>.from(relateSong.map((x) => x)),
    "relatedInfo": relatedInfo,
    "videoUserLiveInfo": videoUserLiveInfo,
    "vid": vid,
    "durationms": durationms,
    "playTime": playTime,
    "praisedCount": praisedCount,
    "praised": praised,
    "subscribed": subscribed,
  };
}

class Creator {
  Creator({
    this.defaultAvatar,
    this.province,
    this.authStatus,
    this.followed,
    this.avatarUrl,
    this.accountStatus,
    this.gender,
    this.city,
    this.birthday,
    this.userId,
    this.userType,
    this.nickname,
    this.signature,
    this.description,
    this.detailDescription,
    this.avatarImgId,
    this.backgroundImgId,
    this.backgroundUrl,
    this.authority,
    this.mutual,
    this.expertTags,
    this.experts,
    this.djStatus,
    this.vipType,
    this.remarkName,
    this.avatarImgIdStr,
    this.backgroundImgIdStr,
    this.creatorAvatarImgIdStr,
  });

  bool defaultAvatar;
  int province;
  int authStatus;
  bool followed;
  String avatarUrl;
  int accountStatus;
  int gender;
  int city;
  int birthday;
  int userId;
  int userType;
  String nickname;
  String signature;
  String description;
  String detailDescription;
  double avatarImgId;
  double backgroundImgId;
  String backgroundUrl;
  int authority;
  bool mutual;
  dynamic expertTags;
  dynamic experts;
  int djStatus;
  int vipType;
  dynamic remarkName;
  String avatarImgIdStr;
  String backgroundImgIdStr;
  String creatorAvatarImgIdStr;

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
    defaultAvatar: json["defaultAvatar"],
    province: json["province"],
    authStatus: json["authStatus"],
    followed: json["followed"],
    avatarUrl: json["avatarUrl"],
    accountStatus: json["accountStatus"],
    gender: json["gender"],
    city: json["city"],
    birthday: json["birthday"],
    userId: json["userId"],
    userType: json["userType"],
    nickname: json["nickname"],
    signature: json["signature"],
    description: json["description"],
    detailDescription: json["detailDescription"],
    avatarImgId: json["avatarImgId"].toDouble(),
    backgroundImgId: json["backgroundImgId"].toDouble(),
    backgroundUrl: json["backgroundUrl"],
    authority: json["authority"],
    mutual: json["mutual"],
    expertTags: json["expertTags"],
    experts: json["experts"],
    djStatus: json["djStatus"],
    vipType: json["vipType"],
    remarkName: json["remarkName"],
    avatarImgIdStr: json["avatarImgIdStr"],
    backgroundImgIdStr: json["backgroundImgIdStr"],
    creatorAvatarImgIdStr: json["avatarImgId_str"],
  );

  Map<String, dynamic> toJson() => {
    "defaultAvatar": defaultAvatar,
    "province": province,
    "authStatus": authStatus,
    "followed": followed,
    "avatarUrl": avatarUrl,
    "accountStatus": accountStatus,
    "gender": gender,
    "city": city,
    "birthday": birthday,
    "userId": userId,
    "userType": userType,
    "nickname": nickname,
    "signature": signature,
    "description": description,
    "detailDescription": detailDescription,
    "avatarImgId": avatarImgId,
    "backgroundImgId": backgroundImgId,
    "backgroundUrl": backgroundUrl,
    "authority": authority,
    "mutual": mutual,
    "expertTags": expertTags,
    "experts": experts,
    "djStatus": djStatus,
    "vipType": vipType,
    "remarkName": remarkName,
    "avatarImgIdStr": avatarImgIdStr,
    "backgroundImgIdStr": backgroundImgIdStr,
    "avatarImgId_str": creatorAvatarImgIdStr,
  };
}

class Resolution {
  Resolution({
    this.resolution,
    this.size,
  });

  int resolution;
  int size;

  factory Resolution.fromJson(Map<String, dynamic> json) => Resolution(
    resolution: json["resolution"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "resolution": resolution,
    "size": size,
  };
}

class VideoGroup {
  VideoGroup({
    this.id,
    this.name,
    this.alg,
  });

  int id;
  String name;
  String alg;

  factory VideoGroup.fromJson(Map<String, dynamic> json) => VideoGroup(
    id: json["id"],
    name: json["name"],
    alg: json["alg"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "alg": alg,
  };
}
