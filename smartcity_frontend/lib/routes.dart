import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smartcity_frontend/models/MQTTProvider.dart';
import 'package:smartcity_frontend/models/ServiceProvider.dart';
import 'package:smartcity_frontend/screens//SmartGarbage/screens/list_screen.dart';
import 'package:smartcity_frontend/screens/homeScreen/homeScreen.dart';
import 'package:smartcity_frontend/screens/homeScreen/screens/all_mqtt_view.dart';

final Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => ServiceProvider().smartGarbageService.mainWidget,
};


const homeRoute = "/";
const smartGarbageMainRoute = "/smartGarbageMainRoute";
const smartGarbageMainHistoryRoute = "/smartGarbageMainWorkerHistoryRoute";
const allMqttRoute = '/allMqttMessages';


RouteFactory routes(){
  return (settings){
    final Map<String, dynamic> arguments = settings.arguments;
    Widget screen;

    switch(settings.name){
      case homeRoute:
        screen = HomePage();
        break;
      case smartGarbageMainRoute:
        screen = ServiceProvider().smartGarbageService.mainWidget;
        break;
      case smartGarbageMainHistoryRoute:
        screen = ListScreen(kind: arguments['kind']);
        break;
      case allMqttRoute:
        screen = AllMqttView();
        break;
      default:
        return null;
    }

    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}