import 'package:NumberApp/Chart/line_chart_widget.dart';
import 'package:NumberApp/models/NumberListModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Number.dart';

// This class represents the operations and data associated with
// the chart displayed to the user in the chart page.
class ChartModel extends ChangeNotifier {
  // Build context is required to create the chart, so it is obtained at the
  // top of the widget tree.
  final BuildContext _context;

  // The current chart that is displayed to the user.
  Widget chart = Container();

  // The currently displayed attribute which is being displayed to the user.
  String selected = "Text1";

  // The default graph is for text1 attribute.
  ChartModel({context}) : _context = context {
    generateGraph(1);
  }

  void generateGraph(int textNumber) {
    List<FlSpot> spotList = new List<FlSpot>();
    List<String> xVal = new List<String>();
    List<String> yVal = new List<String>();
    List<Number> num =
        Provider.of<NumberListModel>(_context, listen: false).numbers;

    if (num.isNotEmpty) {
      print("Length:" + num.length.toString());

      int t1, t2;
      if (num.length > 1) {
        if (textNumber == 1) {
          t1 =
              num[num.length - 2].text1 == null ? 0 : num[num.length - 2].text1;
          t2 =
              num[num.length - 1].text1 == null ? 0 : num[num.length - 1].text1;
        } else if (textNumber == 2) {
          t1 =
              num[num.length - 2].text2 == null ? 0 : num[num.length - 2].text2;
          t2 =
              num[num.length - 1].text2 == null ? 0 : num[num.length - 1].text2;
        } else {
          t1 =
              num[num.length - 2].text3 == null ? 0 : num[num.length - 2].text3;
          t2 =
              num[num.length - 1].text3 == null ? 0 : num[num.length - 1].text3;
        }

        spotList.add(FlSpot(2, t1.toDouble()));
        spotList.add(FlSpot(4, t2.toDouble()));

        xVal.add(num[num.length - 2].date);
        xVal.add(num[num.length - 1].date);

        if (t1 < t2) {
          yVal.add(t1.toString());
          yVal.add((t2 + 10).toString());
        } else {
          yVal.add(t2.toString());
          yVal.add((t1 + 10).toString());
        }
      } else {
        if (textNumber == 1) {
          double spotValue = num[0].text1 == null ? 0 : num[0].text1.toDouble();

          spotList.add(new FlSpot(2, spotValue));
          xVal.add(num[0].date);
          yVal.add((spotValue + 10).toString());
          yVal.add("0");
        } else if (textNumber == 2) {
          double spotValue = num[0].text2 == null ? 0 : num[0].text2.toDouble();

          spotList.add(new FlSpot(2, spotValue));

          xVal.add(num[0].date);
          yVal.add((spotValue + 10).toString());
          yVal.add("0");
        } else {
          double spotValue = num[0].text3 == null ? 0 : num[0].text3.toDouble();

          spotList.add(new FlSpot(2, spotValue));

          xVal.add(num[0].date);
          yVal.add((spotValue + 10).toString());
          yVal.add("0");
        }
      }
    } else {
      spotList.add(FlSpot(0, 0));
      xVal.add("No records");
      yVal.add("0");
      yVal.add("0");
    }

    // Change the title to whatever attribute is being displayed.
    selected = "Text" + textNumber.toString();

    chart = LineChartWidget(spotList: spotList, xValues: xVal, yValues: yVal);

    // Finally, update the child widgets of listeners.
    notifyListeners();
  }
}
