// @dart=2.9


class Transport  {
  Transport({
    this.ttId,
    this.ttTitle,
    this.ttNote,
  });

  final int ttId;
  final String ttTitle;
  final String ttNote;

  factory Transport.fromJson(Map<String, dynamic> json) => Transport(
    ttId: json["tt_id"],
    ttTitle: json["tt_title"],
    ttNote: json["tt_note"],
  );

  Map<String, dynamic> toJson() => {
    "tt_id": ttId,
    "tt_title": ttTitle,
    "tt_note": ttNote,
  };



  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
}
