// To parse this JSON data, do
//
//     final workerHistory = workerHistoryFromJson(jsonString);

import 'dart:convert';

class WorkerHistory {
  WorkerHistory({
    this.history,
    this.stats,
  });

  List<WorkerHistoryElement> history;
  List<WorkerStat> stats;

  WorkerHistory copyWith({
    List<WorkerHistoryElement> history,
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
        history: List<WorkerHistoryElement>.from(
            json["history"].map((x) => WorkerHistoryElement.fromJson(x))),
        stats: List<WorkerStat>.from(
            json["stats"].map((x) => WorkerStat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "history": List<dynamic>.from(history.map((x) => x.toJson())),
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
      };
}

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
}
