import 'package:equatable/equatable.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/history.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/json.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/umgebungsdaten.dart';

///The state represents the current situation of our app.
///Have we already fetched data? Was that fetch successful?
///The UI responds to the state and can display data or display some
///loading animation like a [CircleProgressBarIndicator].
abstract class SgState extends Equatable {

  Umgebungsdaten get umgebungsdaten;
  SensorHistory get sensorHistory;
  WorkerHistory get workerHistory;
  DateTime get lastUpdate;

  const SgState();

  ///We always want to return a new state object and not to alter the old state.
  ///The copy with method builds a fresh new state based on the old one.
  ///Each parameter that is not given to the method is replaced with its old values.
  ///But the returned state is a new object.
  SgSuccess copyWith(
      {Umgebungsdaten umgebungsdaten,
      SensorHistory sensor_history,
      WorkerHistory worker_history});

  ///The bloc library compares the old and new states. All state properties
  ///have to be passed in this props getter. Otherwise the UI will not be rebuild.
  @override
  List<Object> get props => [umgebungsdaten, sensorHistory, workerHistory];
}

///We currently hold our initial data and a [CircleProgressBarIndicator]
///is shown to the user.
class SgInitial extends SgState {
  final Umgebungsdaten umgebungsdaten = Umgebungsdaten.exampleData();
  final SensorHistory sensor_history = SensorHistory(history: [], stats: []);
  final WorkerHistory worker_history = WorkerHistory(history: [], stats: []);
  final DateTime  last_update = DateTime.now();

  @override
  SgSuccess copyWith({
    Umgebungsdaten umgebungsdaten,
    SensorHistory sensor_history,
    WorkerHistory worker_history,
  }) {
    return SgSuccess(
      umgebungsdaten: umgebungsdaten ?? this.umgebungsdaten,
      sensor_history: sensor_history ?? this.sensor_history,
      worker_history: worker_history ?? this.worker_history,
    );
  }

  @override
  List<Object> get props => [umgebungsdaten, sensor_history, worker_history];

  @override
  String toString() => 'PostInitial { umgebungsdaten: ${umgebungsdaten} } '
      'Sensor-History { history: ${sensor_history} '
      'Worker-History { history: ${worker_history}';

  @override
  SensorHistory get sensorHistory => sensor_history;

  @override
  WorkerHistory get workerHistory => worker_history;

  @override
  DateTime get lastUpdate => last_update;

}

///Some error occurred and we are unable to recover to a normal state.
class SgFailure extends SgState {
  @override
  SgSuccess copyWith(
      {Umgebungsdaten umgebungsdaten,
      SensorHistory sensor_history,
      WorkerHistory worker_history}) {
    throw UnimplementedError();
  }

  @override
  SensorHistory get sensorHistory => throw UnimplementedError();

  @override
  Umgebungsdaten get umgebungsdaten => throw UnimplementedError();

  @override
  WorkerHistory get workerHistory => throw UnimplementedError();

  @override
  DateTime get lastUpdate => throw UnimplementedError();
}

///We successfully fetched data and we are now able to show those to the user.
class SgSuccess extends SgState {
  final Umgebungsdaten umgebungsdaten;
  final SensorHistory sensor_history;
  final WorkerHistory worker_history;
  final DateTime last_Update;

  const SgSuccess({
    this.umgebungsdaten,
    this.sensor_history,
    this.worker_history,
    this.last_Update
  });

  @override
  SgSuccess copyWith({
    Umgebungsdaten umgebungsdaten,
    SensorHistory sensor_history,
    WorkerHistory worker_history,
  }) {
    return SgSuccess(
      umgebungsdaten: umgebungsdaten ?? this.umgebungsdaten,
      sensor_history: sensor_history ?? this.sensor_history,
      worker_history: worker_history ?? this.worker_history,
    );
  }

  @override
  List<Object> get props => [umgebungsdaten, sensor_history, worker_history];

  @override
  String toString() => 'PostSuccess { umgebungsdaten: ${umgebungsdaten} } '
      'Sensor-History { history: ${sensor_history} '
      'Worker-History{ ${worker_history}';

  @override
  SensorHistory get sensorHistory => sensor_history;

  @override
  WorkerHistory get workerHistory => worker_history;

  @override
  DateTime get lastUpdate => last_Update;
}

class SgLoading extends SgState {
  final Umgebungsdaten umgebungsdaten;
  final SensorHistory sensor_history;
  final WorkerHistory worker_history;
  final DateTime last_Update;

  const SgLoading({
    this.umgebungsdaten,
    this.sensor_history,
    this.worker_history,
    this.last_Update
  });


  @override
  SgSuccess copyWith(
      {Umgebungsdaten umgebungsdaten,
      SensorHistory sensor_history,
      WorkerHistory worker_history}) {
    throw UnimplementedError();
  }

  @override
  List<Object> get props => [umgebungsdaten, sensor_history, worker_history];

  @override
  SensorHistory get sensorHistory => sensor_history;

  @override
  WorkerHistory get workerHistory => worker_history;

  @override
  DateTime get lastUpdate => last_Update;
}
