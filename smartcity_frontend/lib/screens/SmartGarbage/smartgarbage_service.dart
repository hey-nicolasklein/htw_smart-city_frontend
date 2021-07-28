import 'package:flutter/cupertino.dart';
import 'package:smartcity_frontend/models/iot_service.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/json.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/sensor_history.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/bloc/bloc.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/bloc/sg_bloc.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/umgebungsdaten.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/screens/smartgarbage_main.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/screens/smartgarbage_widget.dart';


///The SmartGarbageService gives access to all widgets and blocs used
///for the SmartGarbage functionality. It gives access to both the
///homeScreen and main Widget and the underlying data stored in a Bloc.

class SmartGarbageService implements IoTService{

  @override
  String route_main = '/smartGarbageMainRoute';

  @override
  String title = 'Smart Garbage';

  @override
  Widget mainWidget = SmartGarbageMain();
  @override
  Widget homeScreenWidget = SmartGarbageWidget();


  @override
  List<String> topics = [
    'data/Gruppe4/frontend/daten',
    'data/Gruppe4/frontend/sensor_history',
    'data/Gruppe4/frontend/worker_history'
  ];

  /// Bloc that is used by the [SmartGarbageService]
  SgBloc bloc = SgBloc();

  @override
  void onMessage(String topic, String payload) {
    switch (topic) {
      case 'data/Gruppe4/frontend/daten':
        {
          try {
            Umgebungsdaten umgebungsdaten = Umgebungsdaten.fromRawJson(payload);
            print('Raw JSON: $payload encode to object: $umgebungsdaten');
            //smartGarbageCubit.updateUmgebungsdaten(umgebungsdaten);
            bloc.add(UmgebungsdatenFetched(umgebungsdaten));
          } on FormatException catch (e) {
            print('The provided Umgebungsdaten string is not valid JSON, $e');
          }
          break;
        }
      case 'data/Gruppe4/frontend/sensor_history':
        {
          try {
            SensorHistory history = SensorHistory.fromRawJson(payload);
            bloc.add(SensorHistoryFetched(history));
          } on FormatException catch (e) {
            print('The provided SensorHistory string is not valid JSON, $e');
          }
          break;
        }
      case 'data/Gruppe4/frontend/worker_history':
        {
          try {
            WorkerHistory history = WorkerHistory.fromRawJson(payload);
            bloc.add(WorkerHistoryFetched(history));
          } on FormatException catch (e) {
            print('The provided WorkerHistory string is not valid JSON, $e');
          }
          break;
        }
      default:
        {
          print('Message has no topic for GarbageService');
          break;
        }
    }
  }
}