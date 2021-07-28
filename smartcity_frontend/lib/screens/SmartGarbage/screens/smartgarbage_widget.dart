import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcity_frontend/routes.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/bloc/bloc.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/components/time_series_chart.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/json.dart';
import 'package:smartcity_frontend/theme/style.dart';

/// SmartGarbage-HomeScreen Widget that is displayed at the apps homeScreen.
class SmartGarbageWidget extends StatelessWidget {
  Text getSensorText(int status) {
    var currentStatusString = 'Unknown';
    Color color = Colors.blue;
    switch (status) {
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
    return Text(
      currentStatusString,
      style: getTeriaryTextStyle(color),
    );
  }

  /// Translate the worker status integer to a corresponding string message
  Text getWorkerText(int status) {
    var currentStatusString = 'free';
    Color color = Colors.blue;

    switch (status) {
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
          color = Colors.red;
          break;
        }
      case 3:
        {
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
    return Text(
      currentStatusString,
      style: getTeriaryTextStyle(color),
    );
  }

  /// Returns a widget which contains the sensor name and its current status
  Widget getSensorIconBar(Sensor sensor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 20, 5),
      child: Row(
        children: <Widget>[
          //Icon(Icons.memory, color: Colors.blue, size: 30,),
          //SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(sensor.name,
                  style: getSecondaryTextStyle(Colors.blueAccent)),
              getSensorText(sensor.status),
            ],
          ),
        ],
      ),
    );
  }

  /// Returns a widget which contains the worker number and its current status
  Widget getWorkerIconBar(Worker worker) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 15, 5),
      child: Row(
        children: <Widget>[
          //Icon(Icons.memory, color: Colors.blue, size: 30,),
          //SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Worker ${worker.id}',
                  style: getSecondaryTextStyle(Colors.blueAccent)),
              getWorkerText(worker.status),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SgBloc, SgState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () => Navigator.pushNamed(context, smartGarbageMainRoute),
                  title: Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                    child: Text(
                      'Smart Garbage',
                      style: getPrimaryTextStyle(Colors.blue),
                    ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: SizedBox(height: 350,
                          child: SimpleTimeSeriesChart.withWorkerHistory(
                              state.workerHistory, Colors.blue),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          getSensorIconBar(state.umgebungsdaten.sensoren[0]),
                          getSensorIconBar(state.umgebungsdaten.sensoren[1]),
                        ],
                      ),
                      getWorkerIconBar(state.umgebungsdaten.worker[0]),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }
}
