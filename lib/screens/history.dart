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
  // The history widget is always initialized with the latest record's
  // values placed in the text fields.
  @override
  void initState() {
    super.initState();

    // Referesh the list, then fetch the latest record.
    // Referesh is called since at initState because sometimes
    // NumberListModel does not load the data in time, before the page is
    // rendered, causing the TextFields to be blank.
    Provider.of<NumberListModel>(context, listen: false)
        .refresh()
        .then((value) {
      // Try to get the latest record from the Model. Here, an exception may
      // occur if there are no records in the numbers attribute of the
      // NumberListModel when we use numbers.last. In that case we sipply fill
      // the text fields with empty strings.
      try {
        Number latestNumber =
            Provider.of<NumberListModel>(context, listen: false).numbers.last;

        Provider.of<NumberInputModel>(context, listen: false).text1.text =
            latestNumber.text1 == null ? "" : latestNumber.text1.toString();
        Provider.of<NumberInputModel>(context, listen: false).text2.text =
            latestNumber.text2 == null ? "" : latestNumber.text2.toString();
        Provider.of<NumberInputModel>(context, listen: false).text3.text =
            latestNumber.text3 == null ? "" : latestNumber.text3.toString();
      } catch (e) {
        Provider.of<NumberInputModel>(context, listen: false).text1.text = "";
        Provider.of<NumberInputModel>(context, listen: false).text2.text = "";
        Provider.of<NumberInputModel>(context, listen: false).text3.text = "";
      }
    });
  }

  // This function returns the dialog box that is shown to the user when
  // they click an item on the listview present on the homepage.
  // @arg pressedNumber represents record which the user clicked. This is used
  // to identify the record in the database.
  Widget dialogBox(BuildContext context, Number pressedNumber) {
    // Set the text input contents of the dialog box to whatever was currently
    // in the history page's textboxes.
    // Since the database can hold null values for text1, 2 and 3, I have
    // implemented guards against null values. Null values are displayed
    // as empty strings in the dialog box.
    Provider.of<NumberInputModel>(context, listen: false).text1.text =
        pressedNumber.text1 == null ? "" : pressedNumber.text1.toString();
    Provider.of<NumberInputModel>(context, listen: false).text2.text =
        pressedNumber.text2 == null ? "" : pressedNumber.text2.toString();
    Provider.of<NumberInputModel>(context, listen: false).text3.text =
        pressedNumber.text3 == null ? "" : pressedNumber.text3.toString();
    Provider.of<NumberInputModel>(context, listen: false).comment.text =
        pressedNumber.comment.toString();

    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
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
                  maxLines: 3,
                  decoration: const InputDecoration(
                      labelText: 'Comments',
                      labelStyle: TextStyle(fontSize: 15)),
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
              SizedBox(
                height: 25,
              ),
              Container(
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

                            // Clear the comments controller. We dont want comments
                            // put on a cancelled dialog option to be reflected in
                            // any insertions after this ince insert and other
                            // operations are using the same set of controllers..
                            Provider.of<NumberInputModel>(context,
                                    listen: false)
                                .comment
                                .text = "";
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

                              // Clear the comments controller. We dont want comments
                              // put on a editted dialog option to be reflected in
                              // any insertions after this since insert and other
                              // operations are using the same set of controllers.
                              Provider.of<NumberInputModel>(context,
                                      listen: false)
                                  .comment
                                  .text = "";

                              Navigator.of(context).pop();
                            });
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
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
