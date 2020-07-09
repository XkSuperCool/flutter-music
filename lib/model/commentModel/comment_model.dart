// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  CommentModel({
    this.isMusician,
    this.cnum,
    this.userId,
    this.topComments,
    this.moreHot,
    this.hotComments,
    this.commentBanner,
    this.code,
    this.comments,
    this.total,
    this.more,
  });

  bool isMusician;
  int cnum;
  int userId;
  List<dynamic> topComments;
  bool moreHot;
  List<Comment> hotComments;
  dynamic commentBanner;
  int code;
  List<Comment> comments;
  int total;
  bool more;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    isMusician: json["isMusician"],
    cnum: json["cnum"],
    userId: json["userId"],
    topComments: List<dynamic>.from(json["topComments"].map((x) => x)),
    moreHot: json["moreHot"],
    hotComments: List<Comment>.from(json["hotComments"].map((x) => Comment.fromJson(x))),
    commentBanner: json["commentBanner"],
    code: json["code"],
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    total: json["total"],
    more: json["more"],
  );

  Map<String, dynamic> toJson() => {
    "isMusician": isMusician,
    "cnum": cnum,
    "userId": userId,
    "topComments": List<dynamic>.from(topComments.map((x) => x)),
    "moreHot": moreHot,
    "hotComments": List<dynamic>.from(hotComments.map((x) => x.toJson())),
    "commentBanner": commentBanner,
    "code": code,
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    "total": total,
    "more": more,
  };
}

class Comment {
  Comment({
    this.user,
    this.beReplied,
    this.pendantData,
    this.showFloorComment,
    this.status,
    this.commentId,
    this.content,
    this.time,
    this.likedCount,
    this.expressionUrl,
    this.commentLocationType,
    this.parentCommentId,
    this.decoration,
    this.repliedMark,
    this.liked,
  });

  User user;
  List<BeReplied> beReplied;
  PendantData pendantData;
  dynamic showFloorComment;
  int status;
  int commentId;
  String content;
  int time;
  int likedCount;
  dynamic expressionUrl;
  int commentLocationType;
  int parentCommentId;
  Decoration decoration;
  dynamic repliedMark;
  bool liked;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    user: User.fromJson(json["user"]),
    beReplied: List<BeReplied>.from(json["beReplied"].map((x) => BeReplied.fromJson(x))),
    pendantData: json["pendantData"] == null ? null : PendantData.fromJson(json["pendantData"]),
    showFloorComment: json["showFloorComment"],
    status: json["status"],
    commentId: json["commentId"],
    content: json["content"],
    time: json["time"],
    likedCount: json["likedCount"],
    expressionUrl: json["expressionUrl"],
    commentLocationType: json["commentLocationType"],
    parentCommentId: json["parentCommentId"],
    decoration: json["decoration"] == null ? null : Decoration.fromJson(json["decoration"]),
    repliedMark: json["repliedMark"],
    liked: json["liked"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "beReplied": List<dynamic>.from(beReplied.map((x) => x.toJson())),
    "pendantData": pendantData == null ? null : pendantData.toJson(),
    "showFloorComment": showFloorComment,
    "status": status,
    "commentId": commentId,
    "content": content,
    "time": time,
    "likedCount": likedCount,
    "expressionUrl": expressionUrl,
    "commentLocationType": commentLocationType,
    "parentCommentId": parentCommentId,
    "decoration": decoration == null ? null : decoration.toJson(),
    "repliedMark": repliedMark,
    "liked": liked,
  };
}

class BeReplied {
  BeReplied({
    this.user,
    this.beRepliedCommentId,
    this.content,
    this.status,
    this.expressionUrl,
  });

  User user;
  int beRepliedCommentId;
  Content content;
  int status;
  dynamic expressionUrl;

  factory BeReplied.fromJson(Map<String, dynamic> json) => BeReplied(
    user: User.fromJson(json["user"]),
    beRepliedCommentId: json["beRepliedCommentId"],
    content: contentValues.map[json["content"]],
    status: json["status"],
    expressionUrl: json["expressionUrl"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "beRepliedCommentId": beRepliedCommentId,
    "content": contentValues.reverse[content],
    "status": status,
    "expressionUrl": expressionUrl,
  };
}

enum Content { EMPTY, CONTENT, THE_2020 }

final contentValues = EnumValues({
  "感觉我挺矫情的，但我还是想说:陌生人，能不能鼓励鼓励我？": Content.CONTENT,
  "乐此不疲的蝉鸣\n明晃晃的水杯\n温热的晚风\n\n蛰睡了一世纪的下午\n伸伸懒腰\n被你的旋律叫醒\n\n你看\n这是我能想到的最棒的夏季": Content.EMPTY,
  "2020年的夏天，经历了新冠，分手，车祸住院，放弃梦想，丢了学位证，被欠工资。也没什么了": Content.THE_2020
});

class User {
  User({
    this.locationInfo,
    this.liveInfo,
    this.anonym,
    this.avatarUrl,
    this.authStatus,
    this.experts,
    this.vipRights,
    this.userId,
    this.userType,
    this.nickname,
    this.vipType,
    this.remarkName,
    this.expertTags,
  });

  dynamic locationInfo;
  dynamic liveInfo;
  int anonym;
  String avatarUrl;
  int authStatus;
  dynamic experts;
  VipRights vipRights;
  int userId;
  int userType;
  String nickname;
  int vipType;
  dynamic remarkName;
  List<String> expertTags;

  factory User.fromJson(Map<String, dynamic> json) => User(
    locationInfo: json["locationInfo"],
    liveInfo: json["liveInfo"],
    anonym: json["anonym"],
    avatarUrl: json["avatarUrl"],
    authStatus: json["authStatus"],
    experts: json["experts"],
    vipRights: json["vipRights"] == null ? null : VipRights.fromJson(json["vipRights"]),
    userId: json["userId"],
    userType: json["userType"],
    nickname: json["nickname"],
    vipType: json["vipType"],
    remarkName: json["remarkName"],
    expertTags: json["expertTags"] == null ? null : List<String>.from(json["expertTags"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "locationInfo": locationInfo,
    "liveInfo": liveInfo,
    "anonym": anonym,
    "avatarUrl": avatarUrl,
    "authStatus": authStatus,
    "experts": experts,
    "vipRights": vipRights == null ? null : vipRights.toJson(),
    "userId": userId,
    "userType": userType,
    "nickname": nickname,
    "vipType": vipType,
    "remarkName": remarkName,
    "expertTags": expertTags == null ? null : List<dynamic>.from(expertTags.map((x) => x)),
  };
}

class VipRights {
  VipRights({
    this.associator,
    this.musicPackage,
    this.redVipAnnualCount,
  });

  Associator associator;
  Associator musicPackage;
  int redVipAnnualCount;

  factory VipRights.fromJson(Map<String, dynamic> json) => VipRights(
    associator: json["associator"] == null ? null : Associator.fromJson(json["associator"]),
    musicPackage: json["musicPackage"] == null ? null : Associator.fromJson(json["musicPackage"]),
    redVipAnnualCount: json["redVipAnnualCount"],
  );

  Map<String, dynamic> toJson() => {
    "associator": associator == null ? null : associator.toJson(),
    "musicPackage": musicPackage == null ? null : musicPackage.toJson(),
    "redVipAnnualCount": redVipAnnualCount,
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

class Decoration {
  Decoration();

  factory Decoration.fromJson(Map<String, dynamic> json) => Decoration(
  );

  Map<String, dynamic> toJson() => {
  };
}

class PendantData {
  PendantData({
    this.id,
    this.imageUrl,
  });

  int id;
  String imageUrl;

  factory PendantData.fromJson(Map<String, dynamic> json) => PendantData(
    id: json["id"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imageUrl": imageUrl,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
