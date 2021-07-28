import 'package:flutter/material.dart';
import 'package:smartcity_frontend/models/ServiceProvider.dart';
import 'package:smartcity_frontend/models/iot_service.dart';

/// Start-Widget of the app. Displays the [homescreen-widget] of each
/// [IoTService] managed by the [ServiceProvider]
class StartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTWSaar SimCity'),
      ),
        backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: ServiceProvider().homescreenWidgets(),
      ),
    );
  }
}
