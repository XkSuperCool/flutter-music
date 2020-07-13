// To parse this JSON data, do
//
//     final searchSongModel = searchSongModelFromJson(jsonString);

import 'dart:convert';

SearchSongModel searchSongModelFromJson(String str) => SearchSongModel.fromJson(json.decode(str));

String searchSongModelToJson(SearchSongModel data) => json.encode(data.toJson());

class SearchSongModel {
  SearchSongModel({
    this.id,
    this.name,
    this.artists,
    this.album,
    this.duration,
    this.copyrightId,
    this.status,
    this.alias,
    this.rtype,
    this.ftype,
    this.mvid,
    this.fee,
    this.rUrl,
    this.mark,
  });

  int id;
  String name;
  List<Artist> artists;
  Album album;
  int duration;
  int copyrightId;
  int status;
  List<dynamic> alias;
  int rtype;
  int ftype;
  int mvid;
  int fee;
  dynamic rUrl;
  int mark;

  factory SearchSongModel.fromJson(Map<String, dynamic> json) => SearchSongModel(
    id: json["id"],
    name: json["name"],
    artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    album: Album.fromJson(json["album"]),
    duration: json["duration"],
    copyrightId: json["copyrightId"],
    status: json["status"],
    alias: List<dynamic>.from(json["alias"].map((x) => x)),
    rtype: json["rtype"],
    ftype: json["ftype"],
    mvid: json["mvid"],
    fee: json["fee"],
    rUrl: json["rUrl"],
    mark: json["mark"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
    "album": album.toJson(),
    "duration": duration,
    "copyrightId": copyrightId,
    "status": status,
    "alias": List<dynamic>.from(alias.map((x) => x)),
    "rtype": rtype,
    "ftype": ftype,
    "mvid": mvid,
    "fee": fee,
    "rUrl": rUrl,
    "mark": mark,
  };
}

class Album {
  Album({
    this.id,
    this.name,
    this.artist,
    this.publishTime,
    this.size,
    this.copyrightId,
    this.status,
    this.picId,
    this.mark,
  });

  int id;
  String name;
  Artist artist;
  int publishTime;
  int size;
  int copyrightId;
  int status;
  int picId;
  int mark;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    id: json["id"],
    name: json["name"],
    artist: Artist.fromJson(json["artist"]),
    publishTime: json["publishTime"],
    size: json["size"],
    copyrightId: json["copyrightId"],
    status: json["status"],
    picId: json["picId"],
    mark: json["mark"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "artist": artist.toJson(),
    "publishTime": publishTime,
    "size": size,
    "copyrightId": copyrightId,
    "status": status,
    "picId": picId,
    "mark": mark,
  };
}

class Artist {
  Artist({
    this.id,
    this.name,
    this.picUrl,
    this.alias,
    this.albumSize,
    this.picId,
    this.img1V1Url,
    this.img1V1,
    this.trans,
  });

  int id;
  String name;
  dynamic picUrl;
  List<dynamic> alias;
  int albumSize;
  int picId;
  String img1V1Url;
  int img1V1;
  dynamic trans;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    id: json["id"],
    name: json["name"],
    picUrl: json["picUrl"],
    alias: List<dynamic>.from(json["alias"].map((x) => x)),
    albumSize: json["albumSize"],
    picId: json["picId"],
    img1V1Url: json["img1v1Url"],
    img1V1: json["img1v1"],
    trans: json["trans"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "picUrl": picUrl,
    "alias": List<dynamic>.from(alias.map((x) => x)),
    "albumSize": albumSize,
    "picId": picId,
    "img1v1Url": img1V1Url,
    "img1v1": img1V1,
    "trans": trans,
  };
}
