// To parse this JSON data, do
//
//     final hotSearchModel = hotSearchModelFromJson(jsonString);

import 'dart:convert';

HotSearchModel hotSearchModelFromJson(String str) => HotSearchModel.fromJson(json.decode(str));

String hotSearchModelToJson(HotSearchModel data) => json.encode(data.toJson());

class HotSearchModel {
  HotSearchModel({
    this.searchWord,
    this.score,
    this.content,
    this.source,
    this.iconType,
    this.iconUrl,
    this.url,
    this.alg,
  });

  String searchWord;
  int score;
  String content;
  int source;
  int iconType;
  String iconUrl;
  String url;
  String alg;

  factory HotSearchModel.fromJson(Map<String, dynamic> json) => HotSearchModel(
    searchWord: json["searchWord"],
    score: json["score"],
    content: json["content"],
    source: json["source"],
    iconType: json["iconType"],
    iconUrl: json["iconUrl"],
    url: json["url"],
    alg: json["alg"],
  );

  Map<String, dynamic> toJson() => {
    "searchWord": searchWord,
    "score": score,
    "content": content,
    "source": source,
    "iconType": iconType,
    "iconUrl": iconUrl,
    "url": url,
    "alg": alg,
  };
}
