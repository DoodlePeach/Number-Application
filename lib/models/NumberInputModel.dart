import 'package:NumberApp/Database/DataBaseHelper.dart';
import 'package:NumberApp/models/Number.dart';
import 'package:flutter/cupertino.dart';

// This class represents the fields displayed to the user
// in the home page.
// Updating the fields there updates Number here accordingly.
// Clicking the save button there runs the insert function here.
class NumberInputModel extends ChangeNotifier {
  // Controllers for getting text from the fields and listening to changes in Number
  // history page.
  final TextEditingController text1 = new TextEditingController(),
      text2 = new TextEditingController(),
      text3 = new TextEditingController(),
      comment = new TextEditingController();

  Future<void> insert() async {
    Number input;
    // Get the time of insrtion for obtaining the date.
    DateTime currentTime = DateTime.now();

    // Get the data from the model. If any of the texts are empty, then insert
    // null values
    try {
      input = new Number(
        text1: text1.text.isNotEmpty ? int.parse(text1.text) : null,
        text2: text2.text.isNotEmpty ? int.parse(text2.text) : null,
        text3: text3.text.isNotEmpty ? int.parse(text3.text) : null,
        date: "${currentTime.day}/${currentTime.month}/${currentTime.year}",
        comment: "",
      );
    } catch (e) {
      print(e.toString());
    }

    // Call async insert function for database here.
    return DatabaseQuery.db.newNumber(input);
  }

  Future<void> update(Number number) async {
    Number input;

    // Get the data from the model. If any of the texts are empty, then insert
    // null values
    try {
      input = new Number(
          text1: text1.text.isNotEmpty ? int.parse(text1.text) : null,
          text2: text2.text.isNotEmpty ? int.parse(text2.text) : null,
          text3: text3.text.isNotEmpty ? int.parse(text3.text) : null,
          comment: comment.text,
          date: number.date,
          id: number.id);
    } catch (e) {
      print(e.toString());
    }

    // Call async update function for database here.
    return DatabaseQuery.db.updateNumber(input, false);
  }
}
