import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/bloc/sg_event.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/bloc/sg_state.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/history.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/json.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/umgebungsdaten.dart';

///The Bloc describes what happens if an event is added.
///The mapEventToState method defines which new state is yielded.
///Here we handle new Umgebungsdaten, WorkerHistory and SensorHistory data.
///For each one is defined, how the resulting new state shall be.
class SgBloc extends Bloc<SgEvent, SgState> {
  SgBloc() : super(SgInitial());

  @override
  Stream<SgState> mapEventToState(SgEvent event) async* {
    final currentState = state;

    ///We fetched new [Umgebungsdaten], now we update the state
    ///accordingly.
    if (event is UmgebungsdatenFetched) {
      final Umgebungsdaten umgebungsdaten = event.umgebungsdaten;
      try {
        ///We already fetched data before. We update and rebuild the widgets.
        if (currentState is SgSuccess) {
          yield SgSuccess(umgebungsdaten: umgebungsdaten,
              worker_history: currentState.workerHistory,
              sensor_history: currentState.sensorHistory,
              last_Update: DateTime.now());

          ///We are currently in the initial state and a [CircleProgressbarIndicator]
          ///is displayed to the user. With the received data we are now able to
          ///change our state and show data to the user.
        } else if (currentState is SgInitial) {
          yield SgLoading(
              umgebungsdaten: umgebungsdaten,
              sensor_history: currentState.sensor_history,
              worker_history: currentState.worker_history,
              last_Update: DateTime.now());
        } else if (currentState is SgLoading) {
          print(
              'Size of sensor: ${currentState.sensor_history.history
                  .length} and the size of worker: ${currentState.worker_history
                  .history.length}');
          if (currentState.sensor_history.history.length > 1 ||
              currentState.worker_history.history.length > 1) {
            yield SgSuccess(
                umgebungsdaten: umgebungsdaten,
                sensor_history: currentState.sensor_history,
                worker_history: currentState.worker_history,
                last_Update: DateTime.now());
          } else {
            yield SgLoading(
                umgebungsdaten: umgebungsdaten,
                sensor_history: currentState.sensor_history,
                worker_history: currentState.worker_history,
                last_Update: DateTime.now());
          }
        }
      } catch (_) {
        yield SgFailure();
      }
    }

    ///We fetched new [SensorHistory] data and update the state accordingly.
    if (event is SensorHistoryFetched) {
      final SensorHistory sensorHistory = event.sensor_history;
      try {
        if (currentState is SgSuccess) {
          yield SgSuccess(umgebungsdaten: currentState.umgebungsdaten,
              worker_history: currentState.workerHistory,
              sensor_history: sensorHistory,
              last_Update: DateTime.now());
        } else if (currentState is SgInitial) {
          yield SgLoading(
              umgebungsdaten: currentState.umgebungsdaten,
              sensor_history: sensorHistory,
              worker_history: currentState.worker_history,
              last_Update: DateTime.now());
        } else if (currentState is SgLoading) {
          if (currentState.sensor_history.history.length > 1 ||
              currentState.worker_history.history.length > 1) {
            yield SgSuccess(
                umgebungsdaten: currentState.umgebungsdaten,
                sensor_history: sensorHistory,
                worker_history: currentState.worker_history,
                last_Update: DateTime.now());
          } else {
            yield SgLoading(
                umgebungsdaten: currentState.umgebungsdaten,
                sensor_history: sensorHistory,
                worker_history: currentState.worker_history,
                last_Update: DateTime.now());
          }
        }
      } catch (_) {
        yield SgFailure();
      }
    }

    ///We fetched new [WorkerHistory] data and update the state accordingly.
    if (event is WorkerHistoryFetched) {
      final WorkerHistory workerHistory = event.worker_history;
      try {
        if (currentState is SgSuccess) {
          yield SgSuccess(umgebungsdaten: currentState.umgebungsdaten,
              worker_history:workerHistory,
              sensor_history: currentState.sensorHistory,
              last_Update: DateTime.now());
        } else if (currentState is SgInitial) {
          yield SgLoading(
              umgebungsdaten: currentState.umgebungsdaten,
              sensor_history: currentState.sensor_history,
              worker_history: workerHistory,
              last_Update: DateTime.now());
        } else if (currentState is SgLoading) {
          if (currentState.sensor_history.history.length > 1 ||
              currentState.worker_history.history.length > 1) {
            yield SgSuccess(
                umgebungsdaten: currentState.umgebungsdaten,
                sensor_history: currentState.sensor_history,
                worker_history: workerHistory,
                last_Update: DateTime.now());
          } else {
            yield SgLoading(
                umgebungsdaten: currentState.umgebungsdaten,
                sensor_history: currentState.sensor_history,
                worker_history: workerHistory,
                last_Update: DateTime.now());
          }
        }
      } catch (_) {
        yield SgFailure();
      }
    }
  }
}
