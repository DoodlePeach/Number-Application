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
      text3 = new TextEditingController();

  Future<void> insert() {
    Number input;

    try {
      input = new Number(
          int.parse(text1.text),
          int.parse(text2.text),
          int.parse(text3.text),
          "",
          "");

    } catch (e) {
      print(e.toString());
    }

    print("Input number was ${input.text1}, ${input.text2} and ${input.text3}");
  }

  void update(Number number) {
    notifyListeners();
  }
}
