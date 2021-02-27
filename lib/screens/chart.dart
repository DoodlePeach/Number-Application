import 'package:NumberApp/models/ChartModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Consumer<ChartModel>(
          builder: (context, data, child) {
            return Column(
              children: [
                data.chart,
                FlatButton(
                  child: Text("Text1"),
                  onPressed: () =>
                      Provider.of<ChartModel>(context, listen: false)
                          .generateGraph(1),
                ),
                FlatButton(
                    child: Text("Text2"),
                    onPressed: () =>
                        Provider.of<ChartModel>(context, listen: false)
                            .generateGraph(2)),
                FlatButton(
                    child: Text("Text3"),
                    onPressed: () =>
                        Provider.of<ChartModel>(context, listen: false)
                            .generateGraph(3))
              ],
            );
          },
        ));
  }
}
