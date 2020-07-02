// To parse this JSON data, do
//
//     final checkMusicModel = checkMusicModelFromJson(jsonString);

import 'dart:convert';

CheckMusicModel checkMusicModelFromJson(String str) => CheckMusicModel.fromJson(json.decode(str));

String checkMusicModelToJson(CheckMusicModel data) => json.encode(data.toJson());

class CheckMusicModel {
  CheckMusicModel({
    this.success,
    this.message,
  });

  bool success;
  String message;

  factory CheckMusicModel.fromJson(Map<String, dynamic> json) => CheckMusicModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
