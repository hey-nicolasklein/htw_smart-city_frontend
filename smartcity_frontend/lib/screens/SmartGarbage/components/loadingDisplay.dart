import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/bloc/bloc.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/json.dart';

/// Information Card that displays the current status and the last time
/// a new message has been received. It informs the user if all initial
/// messages has been received from the broker.
class LoadingDisplay extends StatelessWidget {
  final WorkerHistory workerHistory;
  final SensorHistory sensorHistory;
  final DateTime lastUpdate;

  const LoadingDisplay(
      {Key key, this.workerHistory, this.sensorHistory, this.lastUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SgBloc, SgState>(
      builder: (context, state) {
        if (workerHistory.history.length < 1 ||
            sensorHistory.history.length < 1) {
          return Card(
            elevation: 1,
            shadowColor: Colors.black38,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: ListTile(
              leading: Icon(Icons.cloud_download),
              title: Text('Still loading'),
              subtitle: Text(
                  'Last update: ${lastUpdate.hour}:${lastUpdate.minute.remainder(60).toString().padLeft(2, '0')}Uhr'),
            ),
          );
        } else {
          return Card(
            elevation: 5,
            shadowColor: Colors.black38,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              leading: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              title: Text('Everything loaded'),
              subtitle: Text(
                  'Last update: ${lastUpdate.hour}:${lastUpdate.minute.remainder(60).toString().padLeft(2, '0')}Uhr'),
            ),
          );
        }
      },
    );
  }
}
