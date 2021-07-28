import 'package:equatable/equatable.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/history.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/json.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/umgebungsdaten.dart';

abstract class SgEvent extends Equatable {
  SgEvent();

  @override
  List<Object> get props => [];
}

///New [Umgebungsdaten] have been received.
class UmgebungsdatenFetched extends SgEvent {
  final Umgebungsdaten umgebungsdaten;

  UmgebungsdatenFetched(this.umgebungsdaten) : super();
}

///New [SensorHistory] has been received.
class SensorHistoryFetched extends SgEvent{
  final SensorHistory sensor_history;

  SensorHistoryFetched(this.sensor_history) : super();

}

///New [WorkerHistory] has been received.
class WorkerHistoryFetched extends SgEvent{
  final WorkerHistory worker_history;

  WorkerHistoryFetched(this.worker_history);
}

