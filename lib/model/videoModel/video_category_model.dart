// To parse this JSON data, do
//
//     final videoCategory = videoCategoryFromJson(jsonString);

import 'dart:convert';

VideoCategory videoCategoryFromJson(String str) => VideoCategory.fromJson(json.decode(str));

String videoCategoryToJson(VideoCategory data) => json.encode(data.toJson());

class VideoCategory {
  VideoCategory({
    this.id,
    this.name,
    this.url,
    this.relatedVideoType,
    this.selectTab,
    this.abExtInfo,
  });

  int id;
  String name;
  dynamic url;
  String relatedVideoType;
  bool selectTab;
  dynamic abExtInfo;

  factory VideoCategory.fromJson(Map<String, dynamic> json) => VideoCategory(
    id: json["id"],
    name: json["name"],
    url: json["url"],
    relatedVideoType: json["relatedVideoType"],
    selectTab: json["selectTab"],
    abExtInfo: json["abExtInfo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
    "relatedVideoType": relatedVideoType,
    "selectTab": selectTab,
    "abExtInfo": abExtInfo,
  };
}
