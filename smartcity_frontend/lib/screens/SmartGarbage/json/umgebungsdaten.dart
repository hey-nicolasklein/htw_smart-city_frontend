import 'dart:convert';

/// Contains [sensoren] and [worker] status and current [pickupQueue] at one point of time
/// sent by the Smart-Garbage backend.
class Umgebungsdaten {
  Umgebungsdaten({
    this.sensoren,
    this.worker,
    this.pickupQueue,
  });

  List<Sensor> sensoren;
  List<Worker> worker;
  List<PickupQueueItem> pickupQueue;

  Umgebungsdaten.exampleData() {
    sensoren = [
      Sensor(
          id: '1',
          name: 'Müller',
          coordinates: new Coordinates(x: '10', y: '20'),
          status: 0),
      Sensor(
          id: '2',
          name: 'Hansen',
          coordinates: new Coordinates(x: '10', y: '20'),
          status: 0)
    ];
    worker = [Worker(id: '1', status: 0)];
    pickupQueue = [];
  }

  Umgebungsdaten.copy(Umgebungsdaten umgebungsdaten){
    sensoren = umgebungsdaten.sensoren;
    worker = umgebungsdaten.worker;
    pickupQueue = umgebungsdaten.pickupQueue;
  }

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
  @override
  String toString() {
    return "\nSensoren: $sensoren,\n Worker: $worker, \n Pickup-Queue: $pickupQueue\n";
  }
}

///Contains the pickup-queue at one point of time defined by the [id]
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
  @override
  String toString() {
    return 'id: $id';
  }
}

/// Represents a sensor defined by the [id] its [name] and the corresponding
/// [coordinates] and [status]
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
  @override
  String toString() {
    return 'id: $id , name: $name, coordinates: $coordinates, status: $status';
  }
}

/// Defines the coordinates of one sensor represented by [x] and [y] - coordinates.
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

  @override
  String toString() {
    return 'x: $x, y: $y';
  }
}


/// Represents the status of one worker defined by the [id] and [status] at
/// one point of time.
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

  @override
  String toString() {
    return 'id: $id';
  }
}
