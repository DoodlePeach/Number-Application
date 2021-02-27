import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'line_titles.dart';

class LineChartWidget extends StatelessWidget {
  final List<FlSpot> spotList;
  final List<String> xValues, yValues;

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  LineChartWidget({this.spotList, this.xValues, this.yValues});

  @override
  Widget build(BuildContext context) => LineChart(
        LineChartData(
          minX: 0,
          maxX: 5,
          minY: 0,
          maxY: yValues[1] == "0"
              ? double.parse(yValues[0])
              : double.parse(yValues[1]),
          titlesData: LineTitles.getTitleData(xValues, yValues),
          gridData: FlGridData(
            show: true,
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spotList,
              isCurved: true,
              colors: gradientColors,
              barWidth: 5,
              // dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
            ),
          ],
        ),
      );
}
