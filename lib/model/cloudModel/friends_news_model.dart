// To parse this JSON data, do
//
//     final friendsNewsModel = friendsNewsModelFromJson(jsonString);

import 'dart:convert';

FriendsNewsModel friendsNewsModelFromJson(String str) => FriendsNewsModel.fromJson(json.decode(str));

String friendsNewsModelToJson(FriendsNewsModel data) => json.encode(data.toJson());

class FriendsNewsModel {
  FriendsNewsModel({
    this.event,
    this.lasttime,
  });

  List<Event> event;
  int lasttime;

  factory FriendsNewsModel.fromJson(Map<String, dynamic> json) => FriendsNewsModel(
    event: List<Event>.from(json["event"].map((x) => Event.fromJson(x))),
    lasttime: json["lasttime"],
  );

  Map<String, dynamic> toJson() => {
    "event": List<dynamic>.from(event.map((x) => x.toJson())),
    "lasttime": lasttime,
  };
}

class Event {
  Event({
    this.actName,
    this.pendantData,
    this.forwardCount,
    this.lotteryEventData,
    this.tailMark,
    this.user,
    this.json,
    this.uuid,
    this.eventTime,
    this.extJsonInfo,
    this.tmplId,
    this.expireTime,
    this.rcmdInfo,
    this.pics,
    this.actId,
    this.showTime,
    this.id,
    this.type,
    this.topEvent,
    this.insiteForwardCount,
    this.info,
  });

  dynamic actName;
  dynamic pendantData;
  int forwardCount;
  dynamic lotteryEventData;
  TailMark tailMark;
  User user;
  String json;
  String uuid;
  int eventTime;
  ExtJsonInfo extJsonInfo;
  int tmplId;
  int expireTime;
  dynamic rcmdInfo;
  List<dynamic> pics;
  int actId;
  int showTime;
  int id;
  int type;
  bool topEvent;
  int insiteForwardCount;
  Info info;

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      actName: json["actName"],
      pendantData: json["pendantData"],
      forwardCount: json["forwardCount"],
      lotteryEventData: json["lotteryEventData"],
      tailMark: TailMark.fromJson(json["tailMark"]),
      user: User.fromJson(json["user"]),
      json: json["json"],
      uuid: json["uuid"],
      eventTime: json["eventTime"],
      extJsonInfo: ExtJsonInfo.fromJson(json["extJsonInfo"]),
      tmplId: json["tmplId"],
      expireTime: json["expireTime"],
      rcmdInfo: json["rcmdInfo"],
      pics: List<dynamic>.from(json["pics"].map((x) => x)),
      actId: json["actId"],
      showTime: json["showTime"],
      id: json["id"],
      type: json["type"],
      topEvent: json["topEvent"],
      insiteForwardCount: json["insiteForwardCount"],
      info: Info.fromJson(json["info"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "actName": actName,
    "pendantData": pendantData,
    "forwardCount": forwardCount,
    "lotteryEventData": lotteryEventData,
    "tailMark": tailMark.toJson(),
    "user": user.toJson(),
    "json": json,
    "uuid": uuid,
    "eventTime": eventTime,
    "extJsonInfo": extJsonInfo.toJson(),
    "tmplId": tmplId,
    "expireTime": expireTime,
    "rcmdInfo": rcmdInfo,
    "pics": List<dynamic>.from(pics.map((x) => x)),
    "actId": actId,
    "showTime": showTime,
    "id": id,
    "type": type,
    "topEvent": topEvent,
    "insiteForwardCount": insiteForwardCount,
    "info": info.toJson(),
  };
}

class ExtJsonInfo {
  ExtJsonInfo({
    this.actId,
    this.actIds,
    this.uuid,
    this.extType,
    this.extId,
    this.circleId,
    this.circlePubType,
    this.extParams,
  });

  int actId;
  List<dynamic> actIds;
  String uuid;
  String extType;
  String extId;
  String circleId;
  String circlePubType;
  ExtParams extParams;

  factory ExtJsonInfo.fromJson(Map<String, dynamic> json) => ExtJsonInfo(
    actId: json["actId"],
    actIds: List<dynamic>.from(json["actIds"].map((x) => x)),
    uuid: json["uuid"],
    extType: json["extType"],
    extId: json["extId"],
    circleId: json["circleId"],
    circlePubType: json["circlePubType"],
    extParams: ExtParams.fromJson(json["extParams"]),
  );

  Map<String, dynamic> toJson() => {
    "actId": actId,
    "actIds": List<dynamic>.from(actIds.map((x) => x)),
    "uuid": uuid,
    "extType": extType,
    "extId": extId,
    "circleId": circleId,
    "circlePubType": circlePubType,
    "extParams": extParams.toJson(),
  };
}

class ExtParams {
  ExtParams();

  factory ExtParams.fromJson(Map<String, dynamic> json) => ExtParams(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Info {
  Info({
    this.commentThread,
    this.latestLikedUsers,
    this.liked,
    this.comments,
    this.resourceType,
    this.resourceId,
    this.likedCount,
    this.commentCount,
    this.shareCount,
    this.threadId,
  });

  CommentThread commentThread;
  dynamic latestLikedUsers;
  bool liked;
  dynamic comments;
  int resourceType;
  int resourceId;
  int likedCount;
  int commentCount;
  int shareCount;
  String threadId;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    commentThread: CommentThread.fromJson(json["commentThread"]),
    latestLikedUsers: json["latestLikedUsers"],
    liked: json["liked"],
    comments: json["comments"],
    resourceType: json["resourceType"],
    resourceId: json["resourceId"],
    likedCount: json["likedCount"],
    commentCount: json["commentCount"],
    shareCount: json["shareCount"],
    threadId: json["threadId"],
  );

  Map<String, dynamic> toJson() => {
    "commentThread": commentThread.toJson(),
    "latestLikedUsers": latestLikedUsers,
    "liked": liked,
    "comments": comments,
    "resourceType": resourceType,
    "resourceId": resourceId,
    "likedCount": likedCount,
    "commentCount": commentCount,
    "shareCount": shareCount,
    "threadId": threadId,
  };
}

class CommentThread {
  CommentThread({
    this.id,
    this.resourceType,
    this.commentCount,
    this.likedCount,
    this.shareCount,
    this.hotCount,
    this.latestLikedUsers,
    this.resourceOwnerId,
    this.resourceId,
    this.resourceTitle,
  });

  String id;
  int resourceType;
  int commentCount;
  int likedCount;
  int shareCount;
  int hotCount;
  List<LatestLikedUser> latestLikedUsers;
  int resourceOwnerId;
  int resourceId;
  String resourceTitle;

  factory CommentThread.fromJson(Map<String, dynamic> json) => CommentThread(
    id: json["id"],
    resourceType: json["resourceType"],
    commentCount: json["commentCount"],
    likedCount: json["likedCount"],
    shareCount: json["shareCount"],
    hotCount: json["hotCount"],
    latestLikedUsers: List<LatestLikedUser>.from(json["latestLikedUsers"].map((x) => LatestLikedUser.fromJson(x))),
    resourceOwnerId: json["resourceOwnerId"],
    resourceId: json["resourceId"],
    resourceTitle: json["resourceTitle"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "resourceType": resourceType,
    "commentCount": commentCount,
    "likedCount": likedCount,
    "shareCount": shareCount,
    "hotCount": hotCount,
    "latestLikedUsers": List<dynamic>.from(latestLikedUsers.map((x) => x.toJson())),
    "resourceOwnerId": resourceOwnerId,
    "resourceId": resourceId,
    "resourceTitle": resourceTitle,
  };
}

class LatestLikedUser {
  LatestLikedUser({
    this.s,
    this.t,
  });

  int s;
  int t;

  factory LatestLikedUser.fromJson(Map<String, dynamic> json) => LatestLikedUser(
    s: json["s"],
    t: json["t"],
  );

  Map<String, dynamic> toJson() => {
    "s": s,
    "t": t,
  };
}

class ResourceInfo {
  ResourceInfo({
    this.id,
    this.userId,
    this.name,
    this.imgUrl,
    this.creator,
    this.eventType,
  });

  int id;
  int userId;
  String name;
  dynamic imgUrl;
  dynamic creator;
  int eventType;

  factory ResourceInfo.fromJson(Map<String, dynamic> json) => ResourceInfo(
    id: json["id"],
    userId: json["userId"],
    name: json["name"],
    imgUrl: json["imgUrl"],
    creator: json["creator"],
    eventType: json["eventType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "name": name,
    "imgUrl": imgUrl,
    "creator": creator,
    "eventType": eventType,
  };
}

class TailMark {
  TailMark({
    this.markTitle,
    this.markType,
    this.markResourceId,
    this.markOrpheusUrl,
    this.circle,
  });

  String markTitle;
  String markType;
  String markResourceId;
  String markOrpheusUrl;
  Circle circle;

  factory TailMark.fromJson(Map<String, dynamic> json) => TailMark(
    markTitle: json["markTitle"],
    markType: json["markType"],
    markResourceId: json["markResourceId"],
    markOrpheusUrl: json["markOrpheusUrl"],
    circle: Circle.fromJson(json["circle"]),
  );

  Map<String, dynamic> toJson() => {
    "markTitle": markTitle,
    "markType": markType,
    "markResourceId": markResourceId,
    "markOrpheusUrl": markOrpheusUrl,
    "circle": circle.toJson(),
  };
}

class Circle {
  Circle({
    this.imageUrl,
    this.postCount,
    this.member,
  });

  String imageUrl;
  String postCount;
  String member;

  factory Circle.fromJson(Map<String, dynamic> json) => Circle(
    imageUrl: json["imageUrl"],
    postCount: json["postCount"],
    member: json["member"],
  );

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
    "postCount": postCount,
    "member": member,
  };
}

class User {
  User({
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
    this.urlAnalyze,
    this.vipRights,
    this.userAvatarImgIdStr,
    this.followeds,
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
  bool urlAnalyze;
  VipRights vipRights;
  String userAvatarImgIdStr;
  int followeds;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
    urlAnalyze: json["urlAnalyze"],
    vipRights: VipRights.fromJson(json["vipRights"]),
    userAvatarImgIdStr: json["avatarImgId_str"],
    followeds: json["followeds"],
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
    "urlAnalyze": urlAnalyze,
    "vipRights": vipRights.toJson(),
    "avatarImgId_str": userAvatarImgIdStr,
    "followeds": followeds,
  };
}

class VipRights {
  VipRights({
    this.associator,
    this.musicPackage,
    this.redVipAnnualCount,
  });

  Associator associator;
  dynamic musicPackage;
  int redVipAnnualCount;

  factory VipRights.fromJson(Map<String, dynamic> json) => VipRights(
    associator: Associator.fromJson(json["associator"]),
    musicPackage: json["musicPackage"],
    redVipAnnualCount: json["redVipAnnualCount"],
  );

  Map<String, dynamic> toJson() => {
    "associator": associator.toJson(),
    "musicPackage": musicPackage,
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
