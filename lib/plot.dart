import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'dart:async' show Future;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plots',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Plots'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<dynamic>> _data = [];
  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/0001.csv");
    List<List<dynamic>> _listData =
    const CsvToListConverter().convert(_rawData);
    setState(() {
      _data = _listData;
    });
  }


class _MyHomePageState extends State<MyHomePage> {
  List<SalesData> _chartData;
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SfCartesianChart(
              title: ChartTitle(text: 'Yearly sales analysis'),
              legend: Legend(isVisible: true),
              tooltipBehavior: _tooltipBehavior,
              series: <ChartSeries>[
                LineSeries<SalesData, double>(
                    name: 'Sales',
                    dataSource: _chartData,
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true)
              ],
              primaryXAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
              ),
              primaryYAxis: NumericAxis(
                  labelFormat: '{value}M',
                  numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
            )));
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData(2017, 25),
      SalesData(2018, 12),
      SalesData(2019, 24),
      SalesData(2020, 18),
      SalesData(2021, 30)
    ];
    return chartData;
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}