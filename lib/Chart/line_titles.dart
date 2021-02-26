import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineTitles {

  static getTitleData(List<String> x,List<String> y) => FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      showTitles: true,
      reservedSize: 35,
      getTextStyles: (value) => const TextStyle(
        color: Color(0xff68737d),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      getTitles: (value) {
        switch (value.toInt()) {
          case 2:
            return x[0];
          case 4:
            if(x.length>1)
              return x[1];
        }
        return '';
      },
      margin: 8,
    ),
    leftTitles: SideTitles(
      showTitles: true,
      getTextStyles: (value) => const TextStyle(
        color: Color(0xff67727d),
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      getTitles: (value) {
        switch (value.toInt()) {
          case 0:
            return "0";
          default:
            if(value.toInt()==int.parse(y[0]) || value.toInt()==int.parse(y[1]) || value.toInt()==(int.parse(y[1])-10))
              return value.toInt().toString();
        }
        return '';
      },
      reservedSize: 35,
      margin: 12,
    ),
  );
}