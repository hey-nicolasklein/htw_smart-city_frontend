import 'package:flutter/material.dart';
import 'package:smartcity_frontend/models/ServiceProvider.dart';

abstract class IoTService{

  /// Title of the service used all around the app
  String title;
  /// Route that navigates to the main-widget
  String route_main;

  ///Widget that is displayed full screen and solves the full set of
  ///features indented for the service.
  Widget mainWidget;
  ///HomeScreen-Widget that solves a subset of the [mainWidget] feature set.
  Widget homeScreenWidget;

  /// All mqtt-topics relevant for the service
  List<String> topics;

  /// The [ServiceProvider] calls this method if a message has been received
  /// on a topic defined in [topics]
  void onMessage(String topic, String message);
}