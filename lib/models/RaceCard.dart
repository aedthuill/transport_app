// @dart=2.9

import 'dart:convert';

List<RaceCard> raceCardFromJson(String str) => List<RaceCard>.from(json.decode(str).map((x) => RaceCard.fromJson(x)));

String raceCardToJson(List<RaceCard> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RaceCard {
  RaceCard({
    this.mvId,
    this.rlRacetype,
    this.rcOrderby,
    this.stId,
    this.rcKkp,
    this.rcDistance,
    this.rcKp,
  });

  int mvId;
  int stId;
  String rlRacetype;
  int rcOrderby;

  String rcKkp;
  double rcDistance;
  bool rcKp;

  factory RaceCard.fromJson(Map<String, dynamic> json) => RaceCard(
    mvId: json["mv_id"],
    rlRacetype: json["rl_racetype"],
    rcOrderby: json["rc_orderby"],
    stId: json["st_id"],
    rcKkp: json["rc_kkp"],
    rcDistance: json["rc_distance"],
    rcKp: json["rc_kp"],
  );

  Map<String, dynamic> toJson() => {
    "mv_id": mvId,
    "rl_racetype": rlRacetype,
    "rc_orderby": rcOrderby,
    "st_id": stId,
    "rc_kkp": rcKkp,
    "rc_distance": rcDistance,
    "rc_kp": rcKp,
  };

/* @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }*/
}



List<RaceList> raceListFromJson(String str) => List<RaceList>.from(json.decode(str).map((x) => RaceList.fromJson(x)));

String raceListToJson(List<RaceList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RaceList {
  RaceList({
    this.mvId,
    this.rlRacetype,
    this.rlFirststationId,
    this.rlLaststationId,
  });

  final int mvId;
  final String rlRacetype;
  final int rlFirststationId;
  final int rlLaststationId;

  var rouitingList;

  factory RaceList.fromJson(Map<String, dynamic> json) => RaceList(
    mvId: json["mv_id"],
    rlRacetype: json["rl_racetype"],
    rlFirststationId: json["rl_firststation_id"],
    rlLaststationId: json["rl_laststation_id"],
  );

  Map<String, dynamic> toJson() => {
    "mv_id": mvId,
    "rl_racetype": rlRacetype,
    "rl_firststation_id": rlFirststationId,
    "rl_laststation_id": rlLaststationId,
  };
}
