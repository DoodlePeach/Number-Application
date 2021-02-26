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
  // This function returns the dialog box that is shown to the user when
  // they click an item on the listview present on the homepage.
  // @arg pressedNumber represents record which the user clicked. This is used
  // to identify the record in the database.
  Widget dialogBox(BuildContext context, Number pressedNumber) {
    // Set the text input contents of the dialog box to whatever was currently
    // in the history page's textboxes.
    Provider.of<NumberInputModel>(context, listen: false).text1.text =
        pressedNumber.text1.toString();
    Provider.of<NumberInputModel>(context, listen: false).text2.text =
        pressedNumber.text2.toString();
    Provider.of<NumberInputModel>(context, listen: false).text3.text =
        pressedNumber.text3.toString();

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
                Expanded(child: Text(pressedNumber.date))
              ],
            ),
            TextField(
                decoration: const InputDecoration(
                    labelText: 'Comments', labelStyle: TextStyle(fontSize: 15)),
                controller:
                    Provider.of<NumberInputModel>(context, listen: false)
                        .comment),
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
                Expanded(
                    child: TextField(
                  controller:
                      Provider.of<NumberInputModel>(context, listen: false)
                          .text1,
                ))
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
                Expanded(
                    child: TextField(
                  controller:
                      Provider.of<NumberInputModel>(context, listen: false)
                          .text2,
                ))
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
                Expanded(
                    child: Container(
                        child: TextField(
                  controller:
                      Provider.of<NumberInputModel>(context, listen: false)
                          .text3,
                )))
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          Provider.of<NumberListModel>(context, listen: false)
                              .delete(pressedNumber);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    Expanded(
                      child: FlatButton(
                          child: Text("Edit"),
                          onPressed: () {
                            // Update the number, then refresh the list of numbers
                            // to reflect the changes that occured.
                            Provider.of<NumberInputModel>(context,
                                    listen: false)
                                .update(pressedNumber)
                                .then((value) {
                              Provider.of<NumberListModel>(context,
                                      listen: false)
                                  .refresh();
                            });
                          }),
                    ),
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
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Text1 *',
                        ),
                        controller: Provider.of<NumberInputModel>(context,
                                listen: false)
                            .text1),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Text2 *',
                      ),
                      controller:
                          Provider.of<NumberInputModel>(context, listen: false)
                              .text2,
                    ),
                  ),
                  Expanded(child: Container()),
                  Expanded(
                    child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Text3 *',
                        ),
                        controller: Provider.of<NumberInputModel>(context,
                                listen: false)
                            .text3),
                  ),
                ],
              ),
              Center(
                child: FlatButton(
                  child: Text("Save"),
                  onPressed: () {
                    print("Save pressed");
                    Provider.of<NumberInputModel>(context, listen: false)
                        .insert()
                        .then((value) {
                      Provider.of<NumberListModel>(context, listen: false)
                          .refresh();
                    });
                  },
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              "Number History",
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Consumer<NumberListModel>(
            builder: (context, data, child) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data.numbers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data.numbers[index].date),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          Provider.of<NumberListModel>(context, listen: false)
                              .delete(data.numbers[index]);
                        }),
                    onTap: () {
                      showDialog(
                          context: context,
                          child: dialogBox(context, data.numbers[index]));
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
