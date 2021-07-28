// To parse this JSON data, do
//
//     final history = historyFromJson(jsonString);

import 'dart:convert';

class History {
  History({
    this.history,
  });

  List<HistoryElement> history;

  factory History.fromRawJson(String str) => History.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory History.fromJson(Map<String, dynamic> json) => History(
        history: List<HistoryElement>.from(
            json['history'].map((x) => HistoryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "history": List<dynamic>.from(history.map((x) => x.toJson())),
      };
}

class HistoryElement {
  HistoryElement({
    this.id,
    this.date,
    this.status,
  });

  int id;
  String date;
  int status;

  factory HistoryElement.fromRawJson(String str) =>
      HistoryElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HistoryElement.fromJson(Map<String, dynamic> json) => HistoryElement(
        id: json["id"],
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "status": status,
      };
}
