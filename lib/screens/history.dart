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
  // Controllers for getting text from the fields and listening to changes.
  final TextEditingController _text1 = new TextEditingController(),
      _text2 = new TextEditingController(),
      _text3 = new TextEditingController();

  // Keeps updating numbers in the attached model.
  void updateNumber() {
    Number input;

    try {
      input = new Number(
          text1: int.parse(_text1.text),
          text2: int.parse(_text2.text),
          text3: int.parse(_text3.text));
    } catch (e) {
      print(e.toString());
    }

    print("Update number called");

    Provider.of<NumberInputModel>(context, listen: false).update(input);
  }

  // Listen for changes in the text order to update the backend model.
  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _text1.addListener(updateNumber);
    _text2.addListener(updateNumber);
    _text3.addListener(updateNumber);

    _text1.text = _text2.text = _text3.text = "0";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
                      controller: _text1,
                      onChanged: (value) {
                        updateNumber();
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Text2 *',
                      ),
                      controller: _text2,
                      onChanged: (value) {
                        updateNumber();
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Text3 *',
                      ),
                      controller: _text3,
                      onChanged: (value) {
                        updateNumber();
                      },
                    ),
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
                              Provider.of<NumberListModel>(context,
                                      listen: false)
                                  .delete(data.numbers[index]);
                            }));
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
