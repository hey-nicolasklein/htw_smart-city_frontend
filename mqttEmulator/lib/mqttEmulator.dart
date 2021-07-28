import 'dart:convert';
import 'package:mqttEmulator/model/sensor_history.dart';
import 'package:mqttEmulator/model/umgebungsdaten.dart';
import 'package:mqttEmulator/model/worker_history.dart';
import 'package:mqttEmulator/mqttProvider.dart';
import 'constants.dart' as constants;
import 'dart:io';
import 'dart:math';

///Sends SensorData through MQTT
///Publishes to example topic.
Future<void> emulateSensorData(MQTTProvider client) async {
  var input = 'y';
  var coordinates = <Coordinates>[
    Coordinates(x: '20', y: '200'),
    Coordinates(x: '80', y: '325')
  ];
  var names = <String>['Warken', 'Mustermann'];

  await client.connect();

  while (input == 'y') {
    //Read user input for sensor id
    stdout.writeln('EMULATOR::Which sensor (1 or 2)?');
    input = stdin.readLineSync();
    print('EMULATOR::Generating Sensor Data.');

    if (['1', '2'].contains(input)) {
      //Create sensor
      var sensor = Sensor(
          id: input,
          coordinates: coordinates[int.parse(input) - 1],
          status: 0,
          name: names[int.parse(input) - 1]);
      print(sensor.toJson());

      //Publish created sensor as json
      await client.publish(jsonEncode(sensor), 'test/topic');
      //await MqttUtilities.asyncSleep(3);
    } else {
      print('EMULATOR::Wrong input, choose between 1 and 2');
    }

    stdout.writeln('EMULATOR::Resend data? (y or n)');
    input = stdin.readLineSync();
    if (!['y', 'n'].contains(input)) {
      print('EMULATOR::Input isnt y or n, quiting ...');
      input = 'n';
    }
  }

  //Disconnect from server
  client.disconnect();

  stdout.writeln('EMULATOR::You typed: $input');
}

///Sends Backend Data through MQTT
Future<void> emulateBackendData(MQTTProvider client) async {
  var r = Random();
  var input = 'y';

  var pickup_list = [PickupQueueItem(id: '1'), PickupQueueItem(id: '2')];

  await client.connect();

  while (input == 'y') {
    print('EMULATOR::Generating Backend data.');
    var umgebungsdaten = Umgebungsdaten(pickupQueue: [
      ...pickup_list
        ..shuffle()
        ..sublist(0, r.nextInt(3))
    ], sensoren: [
      Sensor(
          id: '1',
          name: 'Müller',
          coordinates: Coordinates(x: '10', y: '20'),
          status: r.nextInt(3)),
      Sensor(
          id: '2',
          name: 'Hansen',
          coordinates: Coordinates(x: '22', y: '423'),
          status: r.nextInt(3))
    ], worker: [
      Worker(id: '1', status: r.nextInt(3))
    ]);

    //Publish created sensor as json
    await client.publish(
        jsonEncode(umgebungsdaten), constants.topicFrontendDaten);
    //await MqttUtilities.asyncSleep(3);

    stdout.writeln('EMULATOR::Resend data? (y or n)');
    input = stdin.readLineSync();
    if (!['y', 'n'].contains(input)) {
      print('EMULATOR::Input isnt y or n, quiting ...');
      input = 'n';
    }
  }

  //Disconnect from server
  client.disconnect();

  stdout.writeln('EMULATOR::You typed: $input');
}

/*
///Sends workerHistory through MQTT
Future<void> emulateWorkerHistory(MQTTProvider client) async {
  await client.connect();

  var input = 'y';

  while (input == 'y') {
    print('EMULATOR::Generating Backend data.');
    var history = History(history: [
      HistoryElement(id: 1, status: 0, date: DateTime.now().toIso8601String()),
      HistoryElement(id: 1, status: 1, date: DateTime.now().toIso8601String()),
      HistoryElement(id: 1, status: 0, date: DateTime.now().toIso8601String()),
      HistoryElement(id: 1, status: 1, date: DateTime.now().toIso8601String()),
      HistoryElement(id: 1, status: 0, date: DateTime.now().toIso8601String())
    ]);

    print('EMULATOR::Generating Backend data.');
    await client.publish(jsonEncode(history), constants.topicWorkerHistory);

    //await MqttUtilities.asyncSleep(3);

    stdout.writeln('EMULATOR::Resend data? (y or n)');
    input = stdin.readLineSync();
    if (!['y', 'n'].contains(input)) {
      print('Input isnt y or n, quiting ...');
      input = 'n';
    }
  }

  //Disconnect from server
  client.disconnect();
}

///Sends workerHistory through MQTT
Future<void> emulateSensorHistory(MQTTProvider client) async {
  var r = Random();

  await client.connect();
  var input = 'y';

  while (input == 'y') {
    print('EMULATOR::Generating Backend data.');
    var history = History(history: [
      HistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 19).toIso8601String()),
      HistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 19).toIso8601String()),
      HistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 19).toIso8601String()),
      HistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 19).toIso8601String()),
      HistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 20).toIso8601String()),
      HistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 20).toIso8601String()),
      HistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 20).toIso8601String()),
      HistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 20).toIso8601String()),
      HistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 20).toIso8601String()),
      HistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 21).toIso8601String()),
      HistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 21).toIso8601String()),
      HistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 21).toIso8601String()),
      HistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 22).toIso8601String()),
      HistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 23).toIso8601String()),
      HistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 23).toIso8601String()),
    ]);

    await client.publish(jsonEncode(history), constants.topicSensorHistory);

    //await MqttUtilities.asyncSleep(3);

    stdout.writeln('EMULATOR::Resend data? (y or n)');
    input = stdin.readLineSync();
    if (!['y', 'n'].contains(input)) {
      print('EMULATOR::Input isnt y or n, quiting ...');
      input = 'n';
    }
  }

  //Disconnect from server
  client.disconnect();
}

*/
Future<void> emulateSensorHistoryExtended(MQTTProvider client) async {
  var r = Random();

  await client.connect();
  var input = 'y';

  while (input == 'y') {
    print('EMULATOR::Generating Backend data.');

    var exampleHistory = [
      SensorHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 19).toIso8601String()),
      SensorHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 19).toIso8601String()),
      SensorHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 19).toIso8601String()),
      SensorHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 19).toIso8601String()),
      SensorHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 20).toIso8601String()),
      SensorHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 20).toIso8601String()),
      SensorHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 20).toIso8601String()),
      SensorHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 20).toIso8601String()),
      SensorHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 20).toIso8601String()),
      SensorHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 21).toIso8601String()),
      SensorHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 21).toIso8601String()),
      SensorHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 21).toIso8601String()),
      SensorHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 22).toIso8601String()),
      SensorHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 23).toIso8601String()),
      SensorHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 23).toIso8601String()),
    ];
    var exampleStat = [
      SensorStat(
          date: DateTime(2019, 9, 19).toIso8601String(),
          sensor1: r.nextInt(50),
          sensor2: r.nextInt(50)),
      SensorStat(
          date: DateTime(2019, 9, 20).toIso8601String(),
          sensor1: r.nextInt(50),
          sensor2: r.nextInt(50)),
      SensorStat(
          date: DateTime(2019, 9, 21).toIso8601String(),
          sensor1: r.nextInt(50),
          sensor2: r.nextInt(50)),
      SensorStat(
          date: DateTime(2019, 9, 22).toIso8601String(),
          sensor1: r.nextInt(50),
          sensor2: r.nextInt(50)),
      SensorStat(
          date: DateTime(2019, 9, 23).toIso8601String(),
          sensor1: r.nextInt(50),
          sensor2: r.nextInt(50)),
      SensorStat(
          date: DateTime(2019, 9, 24).toIso8601String(),
          sensor1: r.nextInt(50),
          sensor2: r.nextInt(50)),
      SensorStat(
          date: DateTime(2019, 9, 25).toIso8601String(),
          sensor1: r.nextInt(50),
          sensor2: r.nextInt(50)),
      SensorStat(
          date: DateTime(2019, 9, 26).toIso8601String(),
          sensor1: r.nextInt(50),
          sensor2: r.nextInt(50)),
      SensorStat(
          date: DateTime(2019, 9, 27).toIso8601String(),
          sensor1: r.nextInt(50),
          sensor2: r.nextInt(50)),
    ];

    var history = SensorHistory(history: exampleHistory, stats: exampleStat);

    await client.publish(jsonEncode(history), constants.topicSensorHistory);

    //await MqttUtilities.asyncSleep(3);

    stdout.writeln('EMULATOR::Resend data? (y or n)');
    input = stdin.readLineSync();
    if (!['y', 'n'].contains(input)) {
      print('EMULATOR::Input isnt y or n, quiting ...');
      input = 'n';
    }
  }

  //Disconnect from server
  client.disconnect();
}

Future<void> emulateWorkerHistoryExtended(MQTTProvider client) async {
  var r = Random();

  await client.connect();
  var input = 'y';

  while (input == 'y') {
    print('EMULATOR::Generating Backend data.');

    var exampleHistory = [
      WorkerHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 19).toIso8601String()),
      WorkerHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 19).toIso8601String()),
      WorkerHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 19).toIso8601String()),
      WorkerHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 19).toIso8601String()),
      WorkerHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 20).toIso8601String()),
      WorkerHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 20).toIso8601String()),
      WorkerHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 20).toIso8601String()),
      WorkerHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 20).toIso8601String()),
      WorkerHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 20).toIso8601String()),
      WorkerHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 21).toIso8601String()),
      WorkerHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 21).toIso8601String()),
      WorkerHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 21).toIso8601String()),
      WorkerHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 22).toIso8601String()),
      WorkerHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 23).toIso8601String()),
      WorkerHistoryElement(
          id: r.nextInt(2) + 1,
          status: r.nextInt(3),
          date: DateTime(2019, 9, 23).toIso8601String()),
    ];
    var exampleStat = [
      WorkerStat(
          date: DateTime(2019, 9, 19).toIso8601String(), jobs: r.nextInt(30)),
      WorkerStat(
          date: DateTime(2019, 9, 20).toIso8601String(), jobs: r.nextInt(30)),
      WorkerStat(
          date: DateTime(2019, 9, 21).toIso8601String(), jobs: r.nextInt(30)),
      WorkerStat(
          date: DateTime(2019, 9, 22).toIso8601String(), jobs: r.nextInt(30)),
      WorkerStat(
          date: DateTime(2019, 9, 23).toIso8601String(), jobs: r.nextInt(30)),
      WorkerStat(
          date: DateTime(2019, 9, 24).toIso8601String(), jobs: r.nextInt(30)),
      WorkerStat(
          date: DateTime(2019, 9, 25).toIso8601String(), jobs: r.nextInt(30)),
      WorkerStat(
          date: DateTime(2019, 9, 26).toIso8601String(), jobs: r.nextInt(30)),
      WorkerStat(
          date: DateTime(2019, 9, 27).toIso8601String(), jobs: r.nextInt(30)),
    ];

    var history = WorkerHistory(history: exampleHistory, stats: exampleStat);

    await client.publish(jsonEncode(history), constants.topicWorkerHistory);

    //await MqttUtilities.asyncSleep(3);

    stdout.writeln('EMULATOR::Resend data? (y or n)');
    input = stdin.readLineSync();
    if (!['y', 'n'].contains(input)) {
      print('EMULATOR::Input isnt y or n, quiting ...');
      input = 'n';
    }
  }

  //Disconnect from server
  client.disconnect();
}
