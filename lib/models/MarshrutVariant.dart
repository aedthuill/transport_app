// @dart=2.9

import 'dart:convert';

import 'package:hive/hive.dart';
part 'MarshrutVariant.g.dart';
List<ScheduleVariants> scheduleVariantsFromJson(String str) => List<ScheduleVariants>.from(json.decode(str).map((x) => ScheduleVariants.fromJson(x)));

String scheduleVariantsToJson(List<ScheduleVariants> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 2)
class ScheduleVariants {
  ScheduleVariants({
    this.mvId,
    this.mrId,
    this.mvDesc,
    this.mvStartdate,
    this.mvEnddate,
    this.mvEnddateexists,
    this.mvChecksum,
  });

  @HiveField(0)
  final int mvId;
  @HiveField(1)
  final int mrId;
  @HiveField(2)
  String mvDesc;
  @HiveField(3)
  DateTime mvStartdate;
  @HiveField(4)
  DateTime mvEnddate;
  @HiveField(5)
  bool mvEnddateexists;
  @HiveField(6)
  int mvChecksum;

  factory ScheduleVariants.fromJson(Map<String, dynamic> json) => ScheduleVariants(
    mvId: json["mv_id"],
    mrId: json["mr_id"],
    mvDesc: json["mv_desc"],
    mvStartdate: json['mv_startdate'] == null ? null : DateTime.parse(json["mv_startdate"]),
    mvEnddate:json['mv_enddate'] == null ? null : DateTime.parse(json["mv_enddate"]),
    mvEnddateexists: json["mv_enddateexists"],
    mvChecksum: json["mv_checksum"],
  );

  Map<String, dynamic> toJson() => {
    "mv_id": mvId,
    "mr_id": mrId,
    "mv_desc": mvDesc,
    "mv_startdate": mvStartdate.toIso8601String(),
    "mv_enddate": mvEnddate.toIso8601String(),
    "mv_enddateexists": mvEnddateexists,
    "mv_checksum": mvChecksum,
  };
}
