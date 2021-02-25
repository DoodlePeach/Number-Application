import 'dart:collection';

import 'package:NumberApp/Database/DataBaseHelper.dart';
import 'package:NumberApp/models/Number.dart';
import 'package:flutter/cupertino.dart';

// This class represents the list of inserted numbers displayed to the user
// in the home page.
class NumberListModel extends ChangeNotifier {
  List<Number> _numbers = [];
  UnmodifiableListView<Number> get numbers => UnmodifiableListView(_numbers);

  NumberListModel() {
    refresh();
  }

  void refresh() {
    DatabaseQuery.db.getAllNumber().then((List<Number> value) async {
      _numbers = value;
      notifyListeners();
    });
  }

  void insert(Number item) {
    DatabaseQuery.db.newNumber(item);
    refresh();
  }

  void update(Number item) {
    DatabaseQuery.db.updateNumber(item, false);
    refresh();
  }

  void delete(Number item) {
    DatabaseQuery.db.deleteNumber(item);
    refresh();
  }
}
