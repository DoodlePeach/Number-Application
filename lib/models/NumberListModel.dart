import 'dart:collection';

import 'package:NumberApp/models/Number.dart';
import 'package:flutter/cupertino.dart';

// This class represents the list of inserted numbers displayed to the user
// in the home page.
class NumberListModel extends ChangeNotifier {
  final List<Number> _numbers = [
    new Number(text1: 1, text2: 1, text3: 1, time: "12/3/3")
  ];

  UnmodifiableListView<Number> get numbers => UnmodifiableListView(_numbers);

  Future<void> fetch() {}
  Future<void> update() {}
  Future<void> delete(Number number) {}
}
