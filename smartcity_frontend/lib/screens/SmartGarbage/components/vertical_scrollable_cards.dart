import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/components/grouped_bar_chart.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/components/time_series_chart.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/json.dart';

/// Displays a [GroupedBarChart] with [SensorHistory] and a [TimeSeriesChart]
/// with [WorkerHistory] in carousel like vertical-scrollable cards.
class VeticalScrollableCards extends StatefulWidget {
  final WorkerHistory workerHistory;
  final SensorHistory sensorHistory;

  const VeticalScrollableCards(
      {Key key, this.workerHistory, this.sensorHistory})
      : super(key: key);

  @override
  _VeticalScrollableCardsState createState() => _VeticalScrollableCardsState();
}

class _VeticalScrollableCardsState extends State<VeticalScrollableCards> {
  int _index = 0;

  Widget switchGraph(index) {
    switch (index) {
      case 0:
        {
          return Container(
              height: 300,
              child: SimpleTimeSeriesChart.withWorkerHistory(
                  widget.workerHistory, Colors.cyan));
        }
      case 1:
        {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 300,
                child: GroupedBarChart.withHistoryData(widget.sensorHistory)),
          );
        }
      default:
        {
          return Center(
            child: Text('Wrong Index'),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 400, // card height
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: PageView.builder(
            itemCount: 2,
            controller: PageController(viewportFraction:0.8),
            onPageChanged: (int index) => setState(() => _index = index),
            itemBuilder: (_, i) {
              return Transform.scale(
                scale: i == _index ? 1 : 0.9,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.black38,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: switchGraph(i),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
