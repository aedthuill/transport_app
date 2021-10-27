// @dart=2.9

import 'dart:convert';

List<AllArrivalsTransport> allArrivalsTransportFromJson(String str) => List<AllArrivalsTransport>.from(json.decode(str).map((x) => AllArrivalsTransport.fromJson(x)));

String allArrivalsTransportToJson(List<AllArrivalsTransport> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllArrivalsTransport {
  AllArrivalsTransport({
    this.taId,
    this.srvId,
    this.stId,
    this.mrId,
    this.rlRacetype,
    this.uniqueid,
    this.taSystime,
    this.taArrivetime,
    this.mvId,
    this.rcKkp,
    this.taLen2Target,
    this.uInv,
  });

  int taId;
  int srvId;
  int stId;
  int mrId;
  String rlRacetype;
  int uniqueid;
  DateTime taSystime;
  DateTime taArrivetime;
  int mvId;
  String rcKkp;
  double taLen2Target;
  bool uInv;

  factory AllArrivalsTransport.fromJson(Map<String, dynamic> json) => AllArrivalsTransport(
    taId: json["ta_id"],
    srvId: json["srv_id"],
    stId: json["st_id"],
    mrId: json["mr_id"],
    rlRacetype: json["rl_racetype"],
    uniqueid: json["uniqueid"],
    taSystime: json['ta_systime'] == null ? null : DateTime.parse(json['ta_systime']),
    taArrivetime: json['ta_arrivetime'] == null ? null : DateTime.parse(json['ta_arrivetime']),
    mvId: json["mv_id"],
    rcKkp: json["rc_kkp"],
    taLen2Target: json["ta_len2target"].toDouble(),
    uInv: json["u_inv"],
  );

  Map<String, dynamic> toJson() => {
    "ta_id": taId,
    "srv_id": srvId,
    "st_id": stId,
    "mr_id": mrId,
    "rl_racetype": rlRacetype,
    "uniqueid": uniqueid,
    "ta_systime": taSystime.toIso8601String(),
    "ta_arrivetime": taArrivetime.toIso8601String(),
    "mv_id": mvId,
    "rc_kkp": rcKkp,
    "ta_len2target": taLen2Target,
    "u_inv": uInv,
  };
}