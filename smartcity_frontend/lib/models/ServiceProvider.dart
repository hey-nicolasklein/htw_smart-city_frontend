import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcity_frontend/main.dart';
import 'package:smartcity_frontend/models/MQTTProvider.dart';
import 'package:smartcity_frontend/models/iot_service.dart';
import 'package:smartcity_frontend/models/models.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/bloc/bloc.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/smartgarbage_service.dart';

/// Gives access to all the different [IoTService] managed by the application.
/// Each project surrounding the HTWSaar SimCity is managed here.
class ServiceProvider {
  ///ServiceProvider instance
  static final ServiceProvider _singleton = ServiceProvider._internal();

  ///Singleton constructor
  factory ServiceProvider() {
    return _singleton;
  }

  ///Internal Constructor
  ServiceProvider._internal();

  ///Subscribes to every topic defined
  ///by each of the managed [IoTServices].
  void subscribe() {
    services.forEach((service) {
      service.topics.forEach((topic) {
        MQTTProvider().subscribe(topic);
      });
    });
  }

  ///Returns a list containing the homeScreen Widget of each
  List<Widget> homescreenWidgets() {
    return services.map((e) => e.homeScreenWidget).toList();
  }

  ///Calls the [onMessage] Method of every managed [IoTService]
  ///that has the corresponding topic defined
  ///in its topics list.
  void onMessage(String topic, String payload) {
    services
        .where((element) => element.topics.contains(topic))
        .forEach((element) => element.onMessage(topic, payload));
  }


  ///List of all [IoTService]s managed by the [ServiceProvider].
  ///Has to be filled by the setters of each [IoTService].
  List<IoTService> services = [];


  /// [SmartGarbageService] instance
  ///
  /// also specifies getter and setter
  /// setter sets up the instance and adds it
  /// to the [services] list.
  SmartGarbageService _smartGarbageService;

  /// [SmartGarbageService] Getter
  SmartGarbageService get smartGarbageService  => _smartGarbageService;

  /// [SmartGarbageService] Setter
  set smartGarbageService(SmartGarbageService smartGarbageService){
    services.add(smartGarbageService);
    _smartGarbageService = smartGarbageService;
  }

  ///Generates list of [BlocProvider] used by the [MultiBlocProvider] placed
  ///in the [main()].
  ///Every [IoTService] has to place a [BlocProvider] with its [Bloc] here
  ///to have it available for [BlocBuilder] farther down in the Widget-Tree.
  List<BlocProvider<Bloc<dynamic, dynamic>>> buildBlocProviders() => [
    BlocProvider<SgBloc>(
      create: (_) => _smartGarbageService.bloc,
    ),
  ];
}
