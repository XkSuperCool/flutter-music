import 'dart:convert';

MusicItemModel musicItemModelFromJson(String str) => MusicItemModel.fromJson(json.decode(str));

String musicItemModelToJson(MusicItemModel data) => json.encode(data.toJson());

class MusicItemModel {
  MusicItemModel({
    this.name,
    this.id,
    this.pst,
    this.t,
    this.ar,
    this.alia,
    this.pop,
    this.st,
    this.rt,
    this.fee,
    this.v,
    this.crbt,
    this.cf,
    this.al,
    this.dt,
    this.a,
    this.cd,
    this.no,
    this.rtUrl,
    this.ftype,
    this.rtUrls,
    this.djId,
    this.copyright,
    this.sId,
    this.mark,
    this.originCoverType,
    this.single,
    this.noCopyrightRcmd,
    this.mv,
    this.mst,
    this.cp,
    this.rtype,
    this.rurl,
    this.publishTime,
  });

  String name;
  int id;
  int pst;
  int t;
  List<Ar> ar;
  List<dynamic> alia;
  int pop;
  int st;
  String rt;
  int fee;
  int v;
  dynamic crbt;
  String cf;
  Al al;
  int dt;
  dynamic a;
  String cd;
  int no;
  dynamic rtUrl;
  int ftype;
  List<dynamic> rtUrls;
  int djId;
  int copyright;
  int sId;
  int mark;
  int originCoverType;
  int single;
  dynamic noCopyrightRcmd;
  int mv;
  int mst;
  int cp;
  int rtype;
  dynamic rurl;
  int publishTime;

  factory MusicItemModel.fromJson(Map<String, dynamic> json) => MusicItemModel(
    name: json["name"],
    id: json["id"],
    pst: json["pst"],
    t: json["t"],
    ar: List<Ar>.from(json["ar"].map((x) => Ar.fromJson(x))),
    alia: List<dynamic>.from(json["alia"].map((x) => x)),
    pop: json["pop"],
    st: json["st"],
    rt: json["rt"],
    fee: json["fee"],
    v: json["v"],
    crbt: json["crbt"],
    cf: json["cf"],
    al: Al.fromJson(json["al"]),
    dt: json["dt"],
    a: json["a"],
    cd: json["cd"],
    no: json["no"],
    rtUrl: json["rtUrl"],
    ftype: json["ftype"],
    rtUrls: List<dynamic>.from(json["rtUrls"].map((x) => x)),
    djId: json["djId"],
    copyright: json["copyright"],
    sId: json["s_id"],
    mark: json["mark"],
    originCoverType: json["originCoverType"],
    single: json["single"],
    noCopyrightRcmd: json["noCopyrightRcmd"],
    mv: json["mv"],
    mst: json["mst"],
    cp: json["cp"],
    rtype: json["rtype"],
    rurl: json["rurl"],
    publishTime: json["publishTime"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "pst": pst,
    "t": t,
    "ar": List<dynamic>.from(ar.map((x) => x.toJson())),
    "alia": List<dynamic>.from(alia.map((x) => x)),
    "pop": pop,
    "st": st,
    "rt": rt,
    "fee": fee,
    "v": v,
    "crbt": crbt,
    "cf": cf,
    "al": al.toJson(),
    "dt": dt,
    "a": a,
    "cd": cd,
    "no": no,
    "rtUrl": rtUrl,
    "ftype": ftype,
    "rtUrls": List<dynamic>.from(rtUrls.map((x) => x)),
    "djId": djId,
    "copyright": copyright,
    "s_id": sId,
    "mark": mark,
    "originCoverType": originCoverType,
    "single": single,
    "noCopyrightRcmd": noCopyrightRcmd,
    "mv": mv,
    "mst": mst,
    "cp": cp,
    "rtype": rtype,
    "rurl": rurl,
    "publishTime": publishTime,
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
