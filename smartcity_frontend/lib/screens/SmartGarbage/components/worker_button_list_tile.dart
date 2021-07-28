import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcity_frontend/models/MQTTProvider.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/components/button_list_tile.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/umgebungsdaten.dart';

/// Display the current status of a Worker.
/// The widget uses the [ButtonListTile] widget as its base.
class WorkerButtonListTile extends StatelessWidget {
  final Worker worker;

  const WorkerButtonListTile({Key key, this.worker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentStatusString = 'Unknown';
    MaterialColor color = Colors.purple;

    switch (worker.status) {
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
          currentStatusString = 'Working';
          color = Colors.orange;
          break;
        }
      case 3: {
        currentStatusString = 'Paused';
        color = Colors.yellow;
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
      subTitle: 'Worker ${worker.id}',
      color: color,
      icon: Icons.directions_car,
      threeLine: false,
      callback: (){
        Map<String, String> data = {'id':worker.id};
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Worker ${worker.id} status change send.'),
          duration: Duration(seconds: 4),
        ));
        MQTTProvider().publishMessage(
            json.encode(data), 'data/Gruppe4/cozmo/active');
      },
    );
  }
}
