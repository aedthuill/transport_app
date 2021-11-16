// @dart=2.9

import 'dart:convert';

import 'package:hive/hive.dart';
part 'Stops.g.dart';

List<StopList> StopListFromJson(String str) => List<StopList>.from(json.decode(str).map((x) => StopList.fromJson(x)));

String stopsToJson(List<StopList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


@HiveType(typeId: 4)
class StopList {
  StopList({
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
  final int stId;
  @HiveField(1)
  final dynamic okId;
  @HiveField(2)
  final int srId;
  @HiveField(3)
  final String stTitle;
  @HiveField(4)
  final String stDesc;
  @HiveField(5)
  final double stLat;
  @HiveField(6)
  final double stLong;
  @HiveField(7)
  final String stNote;
  @HiveField(8)
  final String stRegnum;

  @HiveField(9)
  var timeArrival;

  factory StopList.fromJson(Map<String, dynamic> json) => StopList(
    stId: json["st_id"],
    okId: json["ok_id"],
    srId: json["sr_id"],
    stTitle: json["st_title"],
    stDesc: json["st_desc"],
    stLat: json["st_lat"],
    stLong: json["st_long"],
    stNote: json["st_note"],
    stRegnum: json["st_regnum"],
  );

  Map<String, dynamic> toJson() => {
    "st_id": stId,
    "ok_id": okId,
    "sr_id": srId,
    "st_title": stTitle,
    "st_desc": stDesc,
    "st_lat": stLat,
    "st_long": stLong,
    "st_note": stNote,
    "st_regnum": stRegnum,
  };
/*
  @override
  String toString() {
    // TODO: implement toString
    return stTitle;
  }*/
}