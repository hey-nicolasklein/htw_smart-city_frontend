import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcity_frontend/models/ServiceProvider.dart';
import 'package:smartcity_frontend/models/constants.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/bloc/bloc.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/history.dart';
import 'package:smartcity_frontend/theme/style.dart';

/// Widget that can display the last received worker-history or sensor-history
/// depending on [kind]
class ListScreen extends StatelessWidget {
  final ListType kind;

  const ListScreen({Key key, this.kind}) : super(key: key);

  /// Translates the status integer of either a sensor or worker to a matching
  /// String message.
  String getInfoText(ListType kind, int status) {
    String currentStatusString = 'unknown';

    switch (status) {
      case 0:
        {
          if (kind == ListType.Sensor) {
            currentStatusString = 'unreachable';
          } else {
            currentStatusString = 'not connected';
          }
          break;
        }
      case 1:
        {
          currentStatusString = 'free';
          break;
        }
      case 2:
        {
          if (kind == ListType.Sensor) {
            currentStatusString = 'occupied';
          } else {
            currentStatusString = 'working';
          }
          break;
        }
      case 3:
        {
          if (kind == ListType.Sensor) {
            currentStatusString = 'unknown';
          } else {
            currentStatusString = 'paused';
          }
          break;
        }
      default:
        {
          currentStatusString = 'unknown';
          break;
        }
    }
    return currentStatusString;
  }

  /// Widget that can be displayed instead of the data.
  /// used while loading, or in an error state.
  /// [text] is the String displayed to the user.
  /// [loading] decides if a [CircularProgressIndicator] is displayed
  /// on top of the [text]
  Widget getInformationWidget(String text, bool loading) {
    if (loading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                text,
                style: HeadingTextStyle,
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
          child: Text(
        text,
        style: HeadingTextStyle,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    String title;

    if (kind == ListType.Worker) {
      title = 'Worker History';
    } else {
      title = 'Sensor History';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.cyan[700],
      ),
      body: BlocBuilder<SgBloc, SgState>(
        //cubit: ServiceProvider().smartGarbageService.bloc,
        builder: (context, state) {
          if (state is SgInitial) {
            return getInformationWidget('Waiting for first data-set.', false);
          } else if (state is SgFailure) {
            return getInformationWidget('Bloc is in error state', false);
          } else {
            List<HistoryElement> history = kind == ListType.Worker
                ? state.workerHistory.history
                : state.sensorHistory.history;
            if (history.isEmpty) {
              return getInformationWidget('Still loading', true);
            }
            return ListView(
              children: <Widget>[
                ...history.map((e) => Card(
                      child: ListTile(
                        leading: Icon(Icons.history),
                        title: Text('Sensor ${e.id} now ' +
                            getInfoText(kind, e.status)),
                        subtitle: Text(DateTime.parse(e.date).toString()),
                      ),
                    ))
              ],
            );
          }
        },
      ),
    );
  }
}
