// To parse this JSON data, do
//
//     final sensorHistory = sensorHistoryFromJson(jsonString);

import 'dart:convert';

class SensorHistory {
  SensorHistory({
    this.history,
    this.stats,
  });

  List<SensorHistoryElement> history;
  List<SensorStat> stats;

  SensorHistory copyWith({
    List<SensorHistoryElement> history,
    List<SensorStat> stats,
  }) =>
      SensorHistory(
        history: history ?? this.history,
        stats: stats ?? this.stats,
      );

  factory SensorHistory.fromRawJson(String str) =>
      SensorHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SensorHistory.fromJson(Map<String, dynamic> json) => SensorHistory(
        history: List<SensorHistoryElement>.from(
            json["history"].map((x) => SensorHistoryElement.fromJson(x))),
        stats: List<SensorStat>.from(
            json["stats"].map((x) => SensorStat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "history": List<dynamic>.from(history.map((x) => x.toJson())),
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
      };
}

class SensorHistoryElement {
  SensorHistoryElement({
    this.id,
    this.status,
    this.date,
  });

  int id;
  String date;
  int status;

  SensorHistoryElement copyWith({
    int id,
    String date,
    int status,
  }) =>
      SensorHistoryElement(
        id: id ?? this.id,
        date: date ?? this.date,
        status: status ?? this.status,
      );

  factory SensorHistoryElement.fromRawJson(String str) =>
      SensorHistoryElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SensorHistoryElement.fromJson(Map<String, dynamic> json) =>
      SensorHistoryElement(
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

class SensorStat {
  SensorStat({
    this.date,
    this.sensor1,
    this.sensor2,
  });

  String date;
  int sensor1;
  int sensor2;

  SensorStat copyWith({
    String date,
    int sensor1,
    int sensor2,
  }) =>
      SensorStat(
        date: date ?? this.date,
        sensor1: sensor1 ?? this.sensor1,
        sensor2: sensor2 ?? this.sensor2,
      );

  factory SensorStat.fromRawJson(String str) =>
      SensorStat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SensorStat.fromJson(Map<String, dynamic> json) => SensorStat(
        date: json["date"],
        sensor1: json["sensor1"],
        sensor2: json["sensor2"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "sensor1": sensor1,
        "sensor2": sensor2,
      };
}
