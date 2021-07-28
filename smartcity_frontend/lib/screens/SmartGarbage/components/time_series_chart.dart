import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/history.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/json.dart';

/// Displays a time-series chart.
/// [SimpleTimeSeriesChart.withWorkerHistory(history, color)] can be used
/// to display the worker history as a chart with jobs on the y-axis and
/// the time period on the x-axis.
class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  factory SimpleTimeSeriesChart.withHistory(SensorHistory history) {
    return new SimpleTimeSeriesChart(
      _createHistory(history, Colors.blue),
      animate: true,
    );
  }

  factory SimpleTimeSeriesChart.withWorkerHistory(WorkerHistory history, Color color) {
    return new SimpleTimeSeriesChart(
      _createWorkerHistoryList(history, color),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      behaviors: [
        new charts.SeriesLegend(),
        new charts.ChartTitle('Days',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleStyleSpec: charts.TextStyleSpec(fontSize: 11),
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        new charts.ChartTitle('Jobs',
            behaviorPosition: charts.BehaviorPosition.start,
            titleStyleSpec: charts.TextStyleSpec(fontSize: 11),
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea)
      ],
    );
  }

  static List<charts.Series<TimeSeriesElement, DateTime>> _createHistory(
      SensorHistory history, Color color) {
    Map<String, List<HistoryElement>> result = history.history
        .fold<Map<String, List<HistoryElement>>>({},
            (historyMap, currentHistoryItem) {
      if (historyMap[currentHistoryItem.date] == null) {
        historyMap[currentHistoryItem.date] = [];
      }
      historyMap[currentHistoryItem.date].add(currentHistoryItem);
      return historyMap;
    });

    List<TimeSeriesElement> historyNumbers = [];

    result.forEach((key, value) {
      historyNumbers.add(TimeSeriesElement(DateTime.parse(key), value.length));
    });

    return [
      new charts.Series(
        id: 'Sensor_History',
        data: historyNumbers,
        domainFn: (TimeSeriesElement sales, _) => sales.time,
        measureFn: (TimeSeriesElement sales, _) => sales.value,
      )
    ];
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesElement, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesElement(new DateTime(2017, 9, 19), 5),
      new TimeSeriesElement(new DateTime(2017, 9, 26), 25),
      new TimeSeriesElement(new DateTime(2017, 10, 3), 100),
      new TimeSeriesElement(new DateTime(2017, 10, 10), 75),
    ];

    return [
      new charts.Series<TimeSeriesElement, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesElement sales, _) => sales.time,
        measureFn: (TimeSeriesElement sales, _) => sales.value,
        data: data,
      )
    ];
  }

  static List<charts.Series<TimeSeriesElement, DateTime>>
      _createWorkerHistoryList(WorkerHistory history, Color color) {
    var historyNumbers = history.stats
        .map((e) => TimeSeriesElement(DateTime.parse(e.date), e.jobs))
        .toList();

    return [
      new charts.Series(
          seriesColor: charts.ColorUtil.fromDartColor(color),
          id: 'Worker 1',
          data: historyNumbers,
          domainFn: (TimeSeriesElement jobs, _) => jobs.time,
          measureFn: (TimeSeriesElement jobs, _) => jobs.value)
    ];
  }
}

/// Sample time series data type.
class TimeSeriesElement {
  final DateTime time;
  final int value;

  TimeSeriesElement(this.time, this.value);

  @override
  String toString() {
    return 'TSE: $time with value of $value';
  }
}
