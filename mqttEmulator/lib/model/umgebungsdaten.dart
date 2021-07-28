import 'dart:convert';

class Umgebungsdaten {
  Umgebungsdaten({
    this.sensoren,
    this.worker,
    this.pickupQueue,
  });

  List<Sensor> sensoren;
  List<Worker> worker;
  List<PickupQueueItem> pickupQueue;

  factory Umgebungsdaten.fromRawJson(String str) =>
      Umgebungsdaten.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Umgebungsdaten.fromJson(Map<String, dynamic> json) => Umgebungsdaten(
        sensoren:
            List<Sensor>.from(json['sensoren'].map((x) => Sensor.fromJson(x))),
        worker:
            List<Worker>.from(json['worker'].map((x) => Worker.fromJson(x))),
        pickupQueue: List<PickupQueueItem>.from(
            json['pickup-queue'].map((x) => PickupQueueItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'sensoren': List<dynamic>.from(sensoren.map((x) => x.toJson())),
        'worker': List<dynamic>.from(worker.map((x) => x.toJson())),
        'pickup-queue': List<dynamic>.from(pickupQueue.map((x) => x.toJson())),
      };
}

class PickupQueueItem {
  PickupQueueItem({
    this.id,
  });

  String id;

  factory PickupQueueItem.fromRawJson(String str) =>
      PickupQueueItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PickupQueueItem.fromJson(Map<String, dynamic> json) =>
      PickupQueueItem(
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
      };
}

class Sensor {
  Sensor({
    this.id,
    this.name,
    this.coordinates,
    this.status,
  });

  String id;
  String name;
  Coordinates coordinates;
  int status;

  factory Sensor.fromRawJson(String str) => Sensor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sensor.fromJson(Map<String, dynamic> json) => Sensor(
        id: json['id'],
        name: json['name'],
        coordinates: Coordinates.fromJson(json['coordinates']),
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'coordinates': coordinates.toJson(),
        'status': status,
      };
}

class Coordinates {
  Coordinates({
    this.x,
    this.y,
  });

  String x;
  String y;

  factory Coordinates.fromRawJson(String str) =>
      Coordinates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        x: json['x'],
        y: json['y'],
      );

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
      };
}

class Worker {
  Worker({
    this.id,
    this.status,
  });

  String id;
  int status;

  factory Worker.fromRawJson(String str) => Worker.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        // ignore: prefer_single_quotes
        id: json['id'],
        // ignore: prefer_single_quotes
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
      };
}
