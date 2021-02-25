import 'package:NumberApp/models/Number.dart';
import 'package:NumberApp/models/NumberInputModel.dart';
import 'package:NumberApp/models/NumberListModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Widget dialogBox(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Edit text",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Data"),
                SizedBox(
                  width: 50,
                ),
                Expanded(child: TextField())
              ],
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Comments', labelStyle: TextStyle(fontSize: 15)),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Text",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Text1",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(child: TextField())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Text2",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(child: TextField())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Text3",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(child: Container(child: TextField()))
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        print("Pressed delete button");
                      },
                    ),
                    FlatButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    FlatButton(
                        child: Text("Edit"),
                        onPressed: () {
                          print("Pressed edit button");
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Consumer<NumberInputModel>(
              builder: (ctxt, data, child) {
                return Column(
                  children: [
                    TextField(
                        decoration: const InputDecoration(
                          labelText: 'Text1 *',
                        ),
                        controller: Provider.of<NumberInputModel>(context,
                                listen: false)
                            .text1),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Text2 *',
                      ),
                      controller:
                          Provider.of<NumberInputModel>(context, listen: false)
                              .text2,
                    ),
                    TextField(
                        decoration: const InputDecoration(
                          labelText: 'Text3 *',
                        ),
                        controller: Provider.of<NumberInputModel>(context,
                                listen: false)
                            .text3),
                    FlatButton(
                      child: Text("Save"),
                      onPressed: () {
                        print("Save pressed");
                        Provider.of<NumberInputModel>(context, listen: false)
                            .insert();
                      },
                    )
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: Consumer<NumberListModel>(
              builder: (context, data, child) {
                return ListView.builder(
                  itemCount: data.numbers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(data.numbers[index].time),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            Provider.of<NumberListModel>(context, listen: false)
                                .delete(data.numbers[index]);
                          }),
                      onTap: () {
                        showDialog(context: context, child: dialogBox(context));
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
