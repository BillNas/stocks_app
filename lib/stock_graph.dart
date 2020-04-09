import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StockSeries {
  final String date;
  final double close;

  StockSeries({@required this.date, @required this.close});
}

class StockChart extends StatelessWidget {
  final List<StockSeries> dataChart;
  final Map dataMapped;

  StockChart({@required this.dataChart,@required this.dataMapped});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<StockSeries, DateTime>> series = [
      charts.Series(
          id: "Stocks",
          colorFn: (_, __) => charts.MaterialPalette.pink.shadeDefault,
          data: dataChart,
          domainFn: (StockSeries series, _) => DateTime(
              int.parse(series.date.split("-")[0]),
              int.parse(series.date.split("-")[1]),
              int.parse(series.date.split("-")[2])),
          measureFn: (StockSeries series, _) => series.close)
      // double.parse(series.date.split("-")[2])
    ];
    return Container(
      color: Colors.white,
      height: 400,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(this.dataMapped["close"].toString(),
                style: TextStyle(fontWeight: FontWeight.w800,fontSize: 46),
              ),
              Expanded(
                child: charts.TimeSeriesChart(
                  series,
                  animate: true,
                  animationDuration: Duration(milliseconds: 500),
                  defaultRenderer:new charts.LineRendererConfig(includeArea: true, stacked: true),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
