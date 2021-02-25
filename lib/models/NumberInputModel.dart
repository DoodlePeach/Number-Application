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
    DateTime currentTime = DateTime.now();

    try {
      input = new Number(
          text1: int.parse(text1.text),
          text2: int.parse(text2.text),
          text3: int.parse(text3.text),
          date: "${currentTime.day}/${currentTime.month}/${currentTime.year}",
          comment: "");
    } catch (e) {
      print(e.toString());
    }

    // Call async insert function for database here.
    return DatabaseQuery.db.newNumber(input);
  }

  Future<void> update(Number number) async {
    Number input;

    try {
      input = new Number(
          text1: int.parse(text1.text),
          text2: int.parse(text2.text),
          text3: int.parse(text3.text),
          comment: comment.text);
    } catch (e) {
      print(e.toString());
    }

    // Call async update function for database here.
    return DatabaseQuery.db.updateNumber(input, false);
  }
}
