import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/Number.dart';

class DatabaseQuery {
  DatabaseQuery._();

  static final DatabaseQuery db = DatabaseQuery._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return openDatabase(join(await getDatabasesPath(), "TestDB.db"), version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Number ("
          "text1 int,"
          "text2 int,"
          "text3 int,"
          "comment TEXT,"
          "date TEXT PRIMARY KEY,"
          "id INTEGER"
          ")");
    });
  }

  newNumber(Number newClient) async {
    final db = await database;
    try {
      var res = await db.insert("Number", newClient.toMap());
      Fluttertoast.showToast(msg: "Added");
    } on DatabaseException {
      Fluttertoast.showToast(msg: "Already Exists in your List");
    }
  }

  Future<List<Number>> getAllNumber() async {
    final db = await database;
    var res = await db.query("Number");
    List<Number> list =
        res.isNotEmpty ? res.map((c) => Number.fromMap(c)).toList() : [];
    return list;
  }

  updateNumber(Number newClient, bool toastOption) async {
    final db = await database;
    try {
      var res = await db.update("Number", newClient.toMap(),
          where: "date = ?", whereArgs: [newClient.date]);
      if (toastOption) Fluttertoast.showToast(msg: "Updated Successfully");
    } on DatabaseException {
      Fluttertoast.showToast(msg: "Not Updated");
    }
  }

  deleteNumber(Number item) async {
    final db = await database;
    try {
      db.delete("Number", where: "date = ?", whereArgs: [item.date]);
      Fluttertoast.showToast(msg: "Deleted Successfuly");
    } on DatabaseException {
      Fluttertoast.showToast(msg: "Not Deleted");
    }
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Number");
  }
}
