import 'package:NumberApp/models/Number.dart';
import 'package:flutter/cupertino.dart';

// This class represents the fields displayed to the user
// in the home page.
// Updating the fields there updates Number here accordingly.
// Clicking the save button there runs the insert function here.
class NumberInputModel extends ChangeNotifier {
  Number _data = new Number(text1: 0, text2: 0, text3: 0);

  Future<void> insert() {}

  void update(Number number) {
    _data = number;

    notifyListeners();
  }
}
