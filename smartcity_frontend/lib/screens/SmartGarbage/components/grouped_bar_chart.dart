import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:smartcity_frontend/screens/SmartGarbage/json/json.dart';

/// Displays a bar chart with two entries per date.
/// [GroupedBarChart.withHistoryData(history)] can be used
/// to display the sensor History as a GroupedBarChart with
/// jobs per Sensor on the y-axis and the time period on the x-axis.
class GroupedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GroupedBarChart(this.seriesList, {this.animate});

  factory GroupedBarChart.withSampleData() {
    return new GroupedBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  factory GroupedBarChart.withHistoryData(SensorHistory history) {
    return new GroupedBarChart(
      _createHistoryData(history),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [new charts.SeriesLegend()],
    );
  }

  static List<charts.Series<OrdinalElement, String>> _createHistoryData(
      SensorHistory history) {

    List<OrdinalElement> sensor1Data = [];
    List<OrdinalElement> sensor2Data = [];

    if(history.history.length >= 7){
      var statsLast7Days =
      history.stats.sublist(history.stats.length - 7, history.stats.length);

      sensor1Data = statsLast7Days
          .map((e) =>
          OrdinalElement(DateTime.parse(e.date).day.toString(), e.sensor1))
          .toList();
      sensor2Data = statsLast7Days
          .map((e) =>
          OrdinalElement(DateTime.parse(e.date).day.toString(), e.sensor2))
          .toList();
    }

    return [
      new charts.Series<OrdinalElement, String>(
          seriesColor: charts.ColorUtil.fromDartColor(Colors.cyan),
          id: 'Sensor1',
          domainFn: (OrdinalElement element, _) => element.day,
          measureFn: (OrdinalElement element, _) => element.value,
          data: sensor1Data),
      new charts.Series<OrdinalElement, String>(
          seriesColor: charts.ColorUtil.fromDartColor(Colors.cyan.shade700),
          id: 'Sensor2',
          domainFn: (OrdinalElement element, _) => element.day,
          measureFn: (OrdinalElement element, _) => element.value,
          data: sensor2Data),
    ];
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalElement, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalElement('2014', 5),
      new OrdinalElement('2015', 25),
      new OrdinalElement('2016', 100),
      new OrdinalElement('2017', 75),
    ];

    final tableSalesData = [
      new OrdinalElement('2014', 25),
      new OrdinalElement('2015', 50),
      new OrdinalElement('2016', 10),
      new OrdinalElement('2017', 20),
    ];

    final mobileSalesData = [
      new OrdinalElement('2014', 10),
      new OrdinalElement('2015', 15),
      new OrdinalElement('2016', 50),
      new OrdinalElement('2017', 45),
    ];

    return [
      new charts.Series<OrdinalElement, String>(
        id: 'Desktop',
        domainFn: (OrdinalElement sales, _) => sales.day,
        measureFn: (OrdinalElement sales, _) => sales.value,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalElement, String>(
        id: 'Tablet',
        domainFn: (OrdinalElement sales, _) => sales.day,
        measureFn: (OrdinalElement sales, _) => sales.value,
        data: tableSalesData,
      ),
      new charts.Series<OrdinalElement, String>(
        id: 'Mobile',
        domainFn: (OrdinalElement sales, _) => sales.day,
        measureFn: (OrdinalElement sales, _) => sales.value,
        data: mobileSalesData,
      ),
    ];
  }
}

/// Ordinal data type.
/// Each element in the bar chart is
/// represented by one [OrdinalElement]
class OrdinalElement {
  final String day;
  final int value;

  OrdinalElement(this.day, this.value);
}
