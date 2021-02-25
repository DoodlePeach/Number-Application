import 'package:NumberApp/Chart/line_chart_widget.dart';
import 'package:NumberApp/models/Number.dart';
import 'package:NumberApp/models/NumberListModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    List<Number> num = Provider.of<NumberListModel>(context,listen: false).numbers;
    List<FlSpot> abc=[FlSpot(2, 4),FlSpot(3,5)];
    List<String> xVal= ["2/Feb","3/Feb"];
    List<String> yVal=["4","10"];
    return Container(
      padding: EdgeInsets.all(20),
      child: Expanded(child: LineChartWidget(abc,xVal,yVal))
    );
  }
}
