// To parse this JSON data, do
//
//     final workerHistory = workerHistoryFromJson(jsonString);

import 'dart:convert';

import 'package:smartcity_frontend/screens/SmartGarbage/json/history.dart';

/// Contains [history] and [stats] containing the worker-status sent by the
/// Smart-Garbage backend.
class WorkerHistory {
  WorkerHistory({
    this.history,
    this.stats,
  });

  List<HistoryElement> history;
  List<WorkerStat> stats;

  WorkerHistory copyWith({
    List<HistoryElement> history,
    List<WorkerStat> stats,
  }) =>
      WorkerHistory(
        history: history ?? this.history,
        stats: stats ?? this.stats,
      );

  factory WorkerHistory.fromRawJson(String str) =>
      WorkerHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorkerHistory.fromJson(Map<String, dynamic> json) => WorkerHistory(
        history: List<HistoryElement>.from(
            json["history"].map((x) => HistoryElement.fromJson(x))),
        stats: List<WorkerStat>.from(
            json["stats"].map((x) => WorkerStat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "history": List<dynamic>.from(history.map((x) => x.toJson())),
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'WorkerHistory: $history, Stats: $stats';
  }
}

/// Represents one item in the [WorkerHistory] defined by its [id], [date] and [status]
class WorkerHistoryElement {
  WorkerHistoryElement({
    this.id,
    this.date,
    this.status,
  });

  int id;
  String date;
  int status;

  WorkerHistoryElement copyWith({
    int id,
    String date,
    int status,
  }) =>
      WorkerHistoryElement(
        id: id ?? this.id,
        date: date ?? this.date,
        status: status ?? this.status,
      );

  factory WorkerHistoryElement.fromRawJson(String str) =>
      WorkerHistoryElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorkerHistoryElement.fromJson(Map<String, dynamic> json) =>
      WorkerHistoryElement(
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
    return 'WorkerHistoryElement: ${this.toRawJson()}';
  }
}

class WorkerStat {
  WorkerStat({
    this.date,
    this.jobs,
  });

  String date;
  int jobs;

  WorkerStat copyWith({
    String date,
    int jobs,
  }) =>
      WorkerStat(
        date: date ?? this.date,
        jobs: jobs ?? this.jobs,
      );

  factory WorkerStat.fromRawJson(String str) =>
      WorkerStat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorkerStat.fromJson(Map<String, dynamic> json) => WorkerStat(
        date: json["date"],
        jobs: json["jobs"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "jobs": jobs,
      };

  @override
  String toString() {
    return 'WorkerHistoryStat: ${this.toRawJson()}';
  }
}
