import 'package:NumberApp/Chart/line_chart_widget.dart';
import 'package:NumberApp/models/Number.dart';
import 'package:NumberApp/models/NumberListModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartPage extends StatelessWidget {

  List<FlSpot> spotList = new List<FlSpot>();
  List<String> xVal= new List<String>();
  List<String> yVal= new List<String>();
  List<Number> num;


  @override
  Widget build(BuildContext context) {

    num = Provider.of<NumberListModel>(context,listen: false).numbers;

    return Container(
      padding: EdgeInsets.all(20),
      child: Expanded(child: textFunction(3))
    );
  }

  LineChartWidget textFunction(int textNo){
    spotList.clear();
    xVal.clear();
    yVal.clear();
    if(num.isNotEmpty){
      print("Length:"+num.length.toString());

      int t1,t2;
      if(num.length>1) {

          if(textNo==1){
            t1 = num[num.length - 2].text1;
            t2 = num[num.length - 1].text1;
          }
          else if(textNo==2){
            t1 = num[num.length - 2].text2;
            t2 = num[num.length - 1].text2;
          }
          else {
            t1 = num[num.length - 2].text3;
            t2 = num[num.length - 1].text3;
          }

        spotList.add(FlSpot(2, t1.toDouble()));
        spotList.add(FlSpot(4, t2.toDouble()));

        xVal.add(num[num.length - 2].date);
        xVal.add(num[num.length - 1].date);

        if(t1<t2) {
          yVal.add(t1.toString());
          yVal.add((t2 + 10).toString());
        }else{
          yVal.add(t2.toString());
          yVal.add((t1 + 10).toString());
        }
      }
      else{
          if(textNo==1)
            spotList.add(new FlSpot(2, num[0].text1.toDouble()));
          else if(textNo==2)
            spotList.add(new FlSpot(2, num[0].text2.toDouble()));
          else
            spotList.add(new FlSpot(2, num[0].text3.toDouble()));

        xVal.add(num[0].date);
        yVal.add((num[0].text1+10).toString());
        yVal.add("0");
      }
    }
   return LineChartWidget(spotList,xVal,yVal);
  }
}
