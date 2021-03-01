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

  Future<void> refresh() async {
    return DatabaseQuery.db.getAllNumber().then((List<Number> value) async {
      _numbers = value;
      notifyListeners();
    });
  }

  Future<void> delete(Number item) async {
    DatabaseQuery.db.deleteNumber(item);
    refresh();
  }
}
