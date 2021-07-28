import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcity_frontend/bloc/simple_bloc_observer.dart';
import 'package:smartcity_frontend/models/MQTTProvider.dart';
import 'package:smartcity_frontend/models/ServiceProvider.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/smartgarbage_service.dart';
import 'package:smartcity_frontend/theme/style.dart';
import 'routes.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp() {
    MQTTProvider().prepareClient();

    SmartGarbageService garbageService = SmartGarbageService();

    ServiceProvider().smartGarbageService = garbageService;

    ServiceProvider().subscribe();
  }



  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: ServiceProvider().buildBlocProviders(),
      child: MaterialApp(
        title: 'SmartCityFrontend',
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        initialRoute: '/',
        onGenerateRoute: routes(),
      ),
    );
  }
}

