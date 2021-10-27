// @dart=2.9



// To parse this JSON data, do
//
//     final currentArrivalTime = currentArrivalTimeFromJson(jsonString);

import 'dart:convert';

List<CurrentArrivalTime> currentArrivalTimeFromJson(String str) => List<CurrentArrivalTime>.from(json.decode(str).map((x) => CurrentArrivalTime.fromJson(x)));

String currentArrivalTimeToJson(List<CurrentArrivalTime> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CurrentArrivalTime {
  CurrentArrivalTime({
    this.tcId,
    this.srvId,
    this.stId,
    this.mrId,
    this.rlRacetype,
    this.uniqueid,
    this.tcSystime,
    this.tcArrivetime,
    this.mvId,
    this.rcKkp,
    this.tcLen2Target,
    this.uInv,
    this.tcGroup,
  });

  int tcId;
  int srvId;
  int stId;
  int mrId;
  String rlRacetype;
  int uniqueid;
  DateTime tcSystime;
  DateTime tcArrivetime;
  int mvId;
  String rcKkp;
  double tcLen2Target;
  bool uInv;
  int tcGroup;

  factory CurrentArrivalTime.fromJson(Map<String, dynamic> json) => CurrentArrivalTime(
    tcId: json["tc_id"],
    srvId: json["srv_id"],
    stId: json["st_id"],
    mrId: json["mr_id"],
    rlRacetype: json["rl_racetype"],
    uniqueid: json["uniqueid"],
    tcSystime: json['tc_systime'] == null ? null : DateTime.parse(json['tc_systime']),
    tcArrivetime: json['tc_arrivetime'] == null ? null : DateTime.parse(json['tc_arrivetime']),
    mvId: json["mv_id"],
    rcKkp: json["rc_kkp"],
    tcLen2Target: json["tc_len2target"],
    uInv: json["u_inv"],
    tcGroup: json["tc_group"],
  );

  Map<String, dynamic> toJson() => {
    "tc_id": tcId,
    "srv_id": srvId,
    "st_id": stId,
    "mr_id": mrId,
    "rl_racetype": rlRacetype,
    "uniqueid": uniqueid,
    "tc_systime": tcSystime.toIso8601String(),
    "tc_arrivetime": tcArrivetime.toIso8601String(),
    "mv_id": mvId,
    "rc_kkp": rcKkp,
    "tc_len2target": tcLen2Target,
    "u_inv": uInv,
    "tc_group": tcGroup,
  };
}
