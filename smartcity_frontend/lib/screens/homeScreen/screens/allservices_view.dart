import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcity_frontend/models/ServiceProvider.dart';
import 'package:smartcity_frontend/models/iot_service.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/bloc/bloc.dart';

/// Widget that displays all available [IoTService] in a list.
/// Each list item can be tapped to navigate to the [main-widget] of the
/// corresponding service.
class AllServicesView extends StatelessWidget {
  Widget getLastUpdateText(int hour, int minute) {
    return Text('Last Update: ${hour}:'
        '${minute.remainder(60).toString().padLeft(2, '0')}Uhr');
  }

  /// Returns one Tile-Widget. Each list item uses this method
  /// to generate its tile.
  Widget getTile(IconData icon, String title, String route,
      BuildContext context, {color= Colors.white}) {
    return BlocBuilder<SgBloc, SgState>(
      builder: (context, state) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: color,
          child: ListTile(
            leading: Icon(
              icon,
              color: Colors.black,
            ),
            title: Text(title),
            subtitle: getLastUpdateText(
                state.lastUpdate.hour, state.lastUpdate.minute),
            onTap: () => Navigator.pushNamed(context, route),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Services'),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            getTile(Icons.cloud_download, 'All MQTT Messages',
                '/allMqttMessages', context, color: Colors.yellow),
            getTile(Icons.drive_eta, 'GarbageService', '/smartGarbageMainRoute', context),
          ],
        ),
      ),
    );
  }
}
