import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:smartcity_frontend/models/MQTTProvider.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/components/button_list_tile.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/umgebungsdaten.dart';

/// Display the current status of a Sensor.
/// The widget uses the [ButtonListTile] widget as its base.
class SensorButtonListTile extends StatelessWidget {
  final Sensor sensor;

  const SensorButtonListTile({Key key, this.sensor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentStatusString = 'Unknown';
    MaterialColor color = Colors.purple;
    switch (sensor.status) {
      case 0:
        {
          currentStatusString = 'Detached';
          color = Colors.grey;
          break;
        }
      case 1:
        {
          currentStatusString = 'Free';
          color = Colors.green;
          break;
        }
      case 2:
        {
          currentStatusString = 'Occupied';
          color = Colors.red;
          break;
        }
      default:
        {
          currentStatusString = 'Unknown';
          color = Colors.purple;
          break;
        }
    }

    return ButtonListTile(
      title: currentStatusString,
      subTitle: sensor.name,
      color: color,
      icon: Icons.settings_input_antenna,
      threeLine: false,
      callback: () async{
        Map<String, String> data = {'id': sensor.id};
        MQTTProvider().publishMessage(
            json.encode(data), 'data/Gruppe4/prioritise_sensor');
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Sensor ${sensor.id} prioritised.'),
          duration: Duration(seconds: 4),
        ));
      },
    );
  }
}
