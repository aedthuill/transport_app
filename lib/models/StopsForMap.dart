// @dart=2.9


import 'dart:convert';

import 'package:hive/hive.dart';
part 'StopsForMap.g.dart';
List<Stop> stopFromJson(String str) => List<Stop>.from(json.decode(str).map((x) => Stop.fromJson(x)));

String stopToJson(List<Stop> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
@HiveType(typeId: 3)
class Stop {
  Stop({
    this.stId,
    this.okId,
    this.srId,
    this.stTitle,
    this.stDesc,
    this.stLat,
    this.stLong,
    this.stNote,
    this.stRegnum,
  });
  @HiveField(0)
  int stId;
  @HiveField(1)
  String okId;
  @HiveField(2)
  int srId;
  @HiveField(3)
  String stTitle;
  @HiveField(4)
  String stDesc;
  @HiveField(5)
  double stLat;
  @HiveField(6)
  double stLong;
  @HiveField(7)
  String stNote;
  String stRegnum;

  factory Stop.fromRawJson(String str) => Stop.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Stop.fromJson(Map<String, dynamic> json) => Stop(
    stId: json["st_id"],
    okId: json["ok_id"] == null ? null : json["ok_id"],
    srId: json["sr_id"],
    stTitle: json["st_title"],
    stDesc: json["st_desc"],
    stLat: json["st_lat"].toDouble(),
    stLong: json["st_long"].toDouble(),
    stNote: json["st_note"],
    stRegnum: json["st_regnum"],
  );

  Map<String, dynamic> toJson() => {
    "st_id": stId,
    "ok_id": okId == null ? null : okId,
    "sr_id": srId,
    "st_title": stTitle,
    "st_desc": stDesc,
    "st_lat": stLat,
    "st_long": stLong,
    "st_note": stNote,
    "st_regnum": stRegnum,
  };

}
