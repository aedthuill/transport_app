// @dart=2.9


import 'dart:convert';

import 'package:hive/hive.dart';
part 'Routes.g.dart';

List<Routes> routesFromJson(String str) => List<Routes>.from(json.decode(str).map((x) => Routes.fromJson(x)));

String routesToJson(List<Routes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


@HiveType(typeId: 1)
class Routes {
  Routes({
    this.mrId,
    this.mrNum,
    this.mrTitle,
    this.mrNote,
    this.ttId,
    this.mtId,
  });

  @HiveField(0)
  final int mrId;
  @HiveField(1)
  final String mrNum;
  @HiveField(2)
  final String mrTitle;
  @HiveField(3)
  final String mrNote;




  final int ttId;
  final int mtId;




  factory Routes.fromJson(Map<String, dynamic> json) => Routes(
    mrId: json["mr_id"],
    ttId: json["tt_id"],
    mtId: json["mt_id"],
    mrNum: json["mr_num"],
    mrTitle: json["mr_title"],

    mrNote: json["mr_note"],

  );

  Map<String, dynamic> toJson() => {

    "mr_id": mrId,
    "tt_id": ttId,
    "mt_id": mtId,
    "mr_num": mrNum,
    "mr_title": mrTitle,
    "mr_note": mrNote,
  };

  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }

}