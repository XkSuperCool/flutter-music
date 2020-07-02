import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  BannerModel({
    this.imageUrl,
    this.targetId,
    this.adid,
    this.targetType,
    this.titleColor,
    this.typeTitle,
    this.url,
  });

  String imageUrl;
  int targetId;
  dynamic adid;
  int targetType;
  String titleColor;
  String typeTitle;
  String url;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    imageUrl: json["imageUrl"],
    targetId: json["targetId"],
    adid: json["adid"],
    targetType: json["targetType"],
    titleColor: json["titleColor"],
    typeTitle: json["typeTitle"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
    "targetId": targetId,
    "adid": adid,
    "targetType": targetType,
    "titleColor": titleColor,
    "typeTitle": typeTitle,
    "url": url,
  };
}
