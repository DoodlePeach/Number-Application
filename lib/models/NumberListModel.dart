import 'dart:collection';

import 'package:NumberApp/Database/DataBaseHelper.dart';
import 'package:NumberApp/models/Number.dart';
import 'package:flutter/cupertino.dart';

// This class represents the operations and data associated with
// the numbers displayed to the user in the home page.
class NumberListModel extends ChangeNotifier {
  List<Number> _numbers = [];

  UnmodifiableListView<Number> get numbers => UnmodifiableListView(_numbers);

  // Every time the app starts up, the numbers list is populated.
  NumberListModel() {
    refresh();
  }

  // Reload the list of stored elements from the database.
  Future<void> refresh() async {
    return DatabaseQuery.db.getAllNumber().then((List<Number> value) async {
      _numbers = value;
      notifyListeners();
    });
  }

  // Delete a specfic number in the database.
  Future<void> delete(Number item) async {
    DatabaseQuery.db.deleteNumber(item);
    refresh();
  }
}
