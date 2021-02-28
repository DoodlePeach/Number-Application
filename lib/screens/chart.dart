import 'package:NumberApp/models/ChartModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Default option selected is Text1 when the page is generated
    // for the first time.
    Provider.of<ChartModel>(context, listen: false).generateGraph(1);

    return Container(
        padding: EdgeInsets.all(20),
        child: Consumer<ChartModel>(
          builder: (context, data, child) {
            return Column(
              children: [
                Container(
                  child: Text(
                    data.selected,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  padding: EdgeInsets.all(5),
                ),
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
