import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcity_frontend/models/constants.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/bloc/bloc.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/components/loadingDisplay.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/components/sensor_button_list_tile.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/components/vertical_scrollable_cards.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/components/worker_button_list_tile.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/components/navigation_button_list_tile.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/json.dart';
import 'package:smartcity_frontend/theme/style.dart';

/// Main-Widget of the GarbageService.
/// It allows the user to see the worker and sensor history,
/// the current status of those and the current pick-up queue.
/// Additionally it is possible to put sensors at the top of the pick-up queue
/// and pause / unpause a worker.
class SmartGarbageMain extends StatelessWidget {

  /// Displays the current pick-up queue
  /// or a single icon if the queue is empty.
  List<Widget> getPickupQueue(List<PickupQueueItem> pickupList) {
    pickupList.length;
    List<Widget> result = [];

    if (pickupList.length == 0) {
      return [
        ListTile(
          leading: Icon(
            Icons.directions_walk,
            color: Colors.white,
          ),
          title: Text(
            'List is Empty',
            style: GoogleFonts.openSans(color: Colors.white70),
          ),
        ),
      ];
    }

    for (var i = 0; i < pickupList.length; i++) {
      result.add(
        Card(
          elevation: 3,
          shadowColor: Colors.black38,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: ListTile(
            leading: getCircleWithNumber(i + 1),
            title: Text(
              pickupList[i].id == '1' ? 'Müller' : 'Hansen',
              style: GoogleFonts.openSans(color: Colors.cyan[800]),
            ),
          ),
        ),
      );
    }
    result.add(
      SizedBox(
        height: 20,
      ),
    );
    return result;
  }

  /// Returns a Heading-Text Widget containing the [title]
  Widget _getHeading(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 5, 5),
      child: Text(
        title,
        style: HeadingTextStyle,
      ),
    );
  }

  /// Returns a blue circle with a number in it.
  /// Used by the pickup queue to indicate positions.
  getCircleWithNumber(int position) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.cyan[800]),
            ),
          ),
          Center(
            child: Text(
              '$position',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  /// Returns two text widgets that show the current total worker jobs
  /// and the current total today worker jobs in a fact like fashion
  /// with big numbers.
  Widget getStatsWidget(WorkerHistory workerHistory) {
    int jobsTotal = 0;
    int jobsToday = 0;
    if (workerHistory.stats.isNotEmpty) {
      jobsTotal = workerHistory.stats
          .fold(0, (previousValue, element) => previousValue + element.jobs);
      jobsToday = workerHistory.stats.last.jobs;
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
              title: Text(
                'Jobs total',
                style: getTeriaryTextStyleSized(Colors.white, 20),
              ),
              subtitle: Text(
                '$jobsTotal',
                style: getPrimaryTextStyleSized(Colors.white, 40),
              ),
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                'Jobs today',
                style: getTeriaryTextStyleSized(Colors.white, 20),
              ),
              subtitle: Text(
                '${jobsToday}',
                style: getPrimaryTextStyleSized(
                  Colors.white,
                  40,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Returns the main content of the widget depending on the
  /// current state. If the state is still [SgInitial] a [CircularProgressIndicator]
  /// is displayed. Otherwise the application content is shown to the user.
  Widget getMain(SgState state) {
    var sensoren = state.umgebungsdaten.sensoren;
    var worker = state.umgebungsdaten.worker;

    return ListView(
      padding: EdgeInsets.all(10),
      children: <Widget>[
        LoadingDisplay(
          workerHistory: state.workerHistory,
          sensorHistory: state.sensorHistory,
          lastUpdate: state.lastUpdate,
        ),
        getStatsWidget(state.workerHistory),
        VeticalScrollableCards(
          workerHistory: state.workerHistory,
          sensorHistory: state.sensorHistory,
        ),
        _getHeading('Sensors'),
        Row(
          children: <Widget>[
            SensorButtonListTile(
              sensor: sensoren[0],
            ),
            SensorButtonListTile(
              sensor: sensoren[1],
            ),
          ],
        ),
        _getHeading('Worker'),
        Row(children: <Widget>[
          WorkerButtonListTile(
            worker: worker[0],
          ),
        ]),
        _getHeading('History'),
        Row(
          children: <Widget>[
            NavigationListTile(
              kind: ListType.Worker,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            NavigationListTile(
              kind: ListType.Sensor,
            )
          ],
        ),
        _getHeading('Worker Queue'),
        ...getPickupQueue(state.umgebungsdaten.pickupQueue),
      ],
    );
  }

  /// Displayed if the status is still [SgInitial] to
  /// inform the user that the app is still waiting / loading.
  Widget getLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Waiting for first \n MQTT-Message',
              style: getTeriaryTextStyle(Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SmartGarbage'),
          backgroundColor: Colors.cyan[700],
        ),
        backgroundColor: Colors.cyan,
        body: BlocBuilder<SgBloc, SgState>(
          builder: (context, state) {
            if (state is SgInitial) {
              return getLoadingWidget();
            } else if (state is SgLoading) {
              return getMain(state);
            } else if (state is SgSuccess) {
              return getMain(state);
            }
            ///PostFailure Event
            return Center(
              child: Text('failed to fetch posts'),
            );
          },
        ));
  }
}
