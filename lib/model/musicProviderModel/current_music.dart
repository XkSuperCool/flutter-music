import 'dart:convert';

CurrentMusicModel currentMusicModelFromJson(String str) => CurrentMusicModel.fromJson(json.decode(str));

String currentMusicModelToJson(CurrentMusicModel data) => json.encode(data.toJson());

class CurrentMusicModel {
  CurrentMusicModel({
    this.id,
    this.url,
    this.br,
    this.size,
    this.md5,
    this.code,
    this.expi,
    this.type,
    this.gain,
    this.fee,
    this.uf,
    this.payed,
    this.flag,
    this.canExtend,
    this.freeTrialInfo,
    this.level,
    this.encodeType,
  });

  int id;
  String url;
  int br;
  int size;
  String md5;
  int code;
  int expi;
  String type;
  int gain;
  int fee;
  dynamic uf;
  int payed;
  int flag;
  bool canExtend;
  dynamic freeTrialInfo;
  String level;
  String encodeType;

  factory CurrentMusicModel.fromJson(Map<String, dynamic> json) => CurrentMusicModel(
    id: json["id"],
    url: json["url"],
    br: json["br"],
    size: json["size"],
    md5: json["md5"],
    code: json["code"],
    expi: json["expi"],
    type: json["type"],
    gain: json["gain"],
    fee: json["fee"],
    uf: json["uf"],
    payed: json["payed"],
    flag: json["flag"],
    canExtend: json["canExtend"],
    freeTrialInfo: json["freeTrialInfo"],
    level: json["level"],
    encodeType: json["encodeType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "br": br,
    "size": size,
    "md5": md5,
    "code": code,
    "expi": expi,
    "type": type,
    "gain": gain,
    "fee": fee,
    "uf": uf,
    "payed": payed,
    "flag": flag,
    "canExtend": canExtend,
    "freeTrialInfo": freeTrialInfo,
    "level": level,
    "encodeType": encodeType,
  };
}
