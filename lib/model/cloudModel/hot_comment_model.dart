// To parse this JSON data, do
//
//     final hotCommentModel = hotCommentModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_music/model/musicProviderModel/music_item_model.dart';

HotCommentModel hotCommentModelFromJson(String str) => HotCommentModel.fromJson(json.decode(str));

String hotCommentModelToJson(HotCommentModel data) => json.encode(data.toJson());

class HotCommentModel {
  HotCommentModel({
    this.id,
    this.threadId,
    this.content,
    this.time,
    this.simpleUserInfo,
    this.likedCount,
    this.replyCount,
    this.simpleResourceInfo,
    this.liked,
  });

  int id;
  String threadId;
  String content;
  int time;
  SimpleUserInfo simpleUserInfo;
  int likedCount;
  int replyCount;
  SimpleResourceInfo simpleResourceInfo;
  bool liked;

  factory HotCommentModel.fromJson(Map<String, dynamic> json) => HotCommentModel(
    id: json["id"],
    threadId: json["threadId"],
    content: json["content"],
    time: json["time"],
    simpleUserInfo: SimpleUserInfo.fromJson(json["simpleUserInfo"]),
    likedCount: json["likedCount"],
    replyCount: json["replyCount"],
    simpleResourceInfo: SimpleResourceInfo.fromJson(json["simpleResourceInfo"]),
    liked: json["liked"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "threadId": threadId,
    "content": content,
    "time": time,
    "simpleUserInfo": simpleUserInfo.toJson(),
    "likedCount": likedCount,
    "replyCount": replyCount,
    "simpleResourceInfo": simpleResourceInfo.toJson(),
    "liked": liked,
  };
}

class SimpleResourceInfo {
  SimpleResourceInfo({
    this.songId,
    this.threadId,
    this.name,
    this.artists,
    this.songCoverUrl,
    this.song,
    this.privilege,
  });

  int songId;
  String threadId;
  String name;
  List<Artist> artists;
  String songCoverUrl;
  MusicItemModel song;
  Privilege privilege;

  factory SimpleResourceInfo.fromJson(Map<String, dynamic> json) => SimpleResourceInfo(
    songId: json["songId"],
    threadId: json["threadId"],
    name: json["name"],
    artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    songCoverUrl: json["songCoverUrl"],
    song: MusicItemModel.fromJson(json["song"]),
    privilege: Privilege.fromJson(json["privilege"]),
  );

  Map<String, dynamic> toJson() => {
    "songId": songId,
    "threadId": threadId,
    "name": name,
    "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
    "songCoverUrl": songCoverUrl,
    "song": song.toJson(),
    "privilege": privilege.toJson(),
  };
}

class Artist {
  Artist({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Privilege {
  Privilege({
    this.id,
    this.fee,
    this.payed,
    this.st,
    this.pl,
    this.dl,
    this.sp,
    this.cp,
    this.subp,
    this.cs,
    this.maxbr,
    this.fl,
    this.toast,
    this.flag,
    this.preSell,
  });

  int id;
  int fee;
  int payed;
  int st;
  int pl;
  int dl;
  int sp;
  int cp;
  int subp;
  bool cs;
  int maxbr;
  int fl;
  bool toast;
  int flag;
  bool preSell;

  factory Privilege.fromJson(Map<String, dynamic> json) => Privilege(
    id: json["id"],
    fee: json["fee"],
    payed: json["payed"],
    st: json["st"],
    pl: json["pl"],
    dl: json["dl"],
    sp: json["sp"],
    cp: json["cp"],
    subp: json["subp"],
    cs: json["cs"],
    maxbr: json["maxbr"],
    fl: json["fl"],
    toast: json["toast"],
    flag: json["flag"],
    preSell: json["preSell"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fee": fee,
    "payed": payed,
    "st": st,
    "pl": pl,
    "dl": dl,
    "sp": sp,
    "cp": cp,
    "subp": subp,
    "cs": cs,
    "maxbr": maxbr,
    "fl": fl,
    "toast": toast,
    "flag": flag,
    "preSell": preSell,
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

class SimpleUserInfo {
  SimpleUserInfo({
    this.userId,
    this.nickname,
    this.avatar,
    this.followed,
    this.userType,
  });

  int userId;
  String nickname;
  String avatar;
  bool followed;
  int userType;

  factory SimpleUserInfo.fromJson(Map<String, dynamic> json) => SimpleUserInfo(
    userId: json["userId"],
    nickname: json["nickname"],
    avatar: json["avatar"],
    followed: json["followed"],
    userType: json["userType"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "nickname": nickname,
    "avatar": avatar,
    "followed": followed,
    "userType": userType,
  };
}
