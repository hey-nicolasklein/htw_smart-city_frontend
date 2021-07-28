// To parse this JSON data, do
//
//     final sensorHistory = sensorHistoryFromJson(jsonString);

import 'dart:convert';

import 'package:smartcity_frontend/screens/SmartGarbage/json/history.dart';

/// Contains [history] and [stats] containing the sensor-status sent by the
/// Smart-Garbage backend.
class SensorHistory {
  SensorHistory({
    this.history,
    this.stats,
  });

  List<HistoryElement> history;
  List<SensorStat> stats;

  SensorHistory copyWith({
    List<HistoryElement> history,
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
    history: List<HistoryElement>.from(
        json["history"].map((x) => HistoryElement.fromJson(x))),
    stats: List<SensorStat>.from(
        json["stats"].map((x) => SensorStat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "history": List<dynamic>.from(history.map((x) => x.toJson())),
    "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'SensorHistory: $history, stats: $stats';
  }
}

/// Single element in the sensor history defined by [id], [status] and [date]
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

  @override
  String toString() {
    return 'SensorHistoryElement: ${this.toRawJson()}';
  }
}

/// State of the sensors in one point of time defined by the [date] containing
/// total jobs for [sensor1] and [sensor2]
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

  @override
  String toString() {
    return 'SensorStat: ${this.toRawJson()}';
  }
}
