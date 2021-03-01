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

  // Creating database and Table using initDB function
  initDB() async {
    // Creating database
    return openDatabase(join(await getDatabasesPath(), "TestDB.db"), version: 1,
        onCreate: (Database db, int version) async {
      // Creating table and making date as a primary key
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

  // Inserting new Number into the database
  newNumber(Number newClient) async {
    final db = await database;
    try {
      // Query for inserting number
      var res = await db.insert("Number", newClient.toMap());
      Fluttertoast.showToast(msg: "Added");
    } on DatabaseException {
      // If exception is thrown by database
      Fluttertoast.showToast(msg: "Already Exists in your List");
    }
  }

  // Fetching all numbers from database
  Future<List<Number>> getAllNumber() async {
    final db = await database;
    var res = await db.query("Number");
    //Fetching records from database and convert into number type objects
    List<Number> list =
        res.isNotEmpty ? res.map((c) => Number.fromMap(c)).toList() : [];
    return list;
  }

  //Updating number in the database using date
  updateNumber(Number newClient, bool toastOption) async {
    final db = await database;
    try {
      //Query for updating number
      var res = await db.update("Number", newClient.toMap(),
          where: "date = ?", whereArgs: [newClient.date]);
      if (toastOption) Fluttertoast.showToast(msg: "Updated Successfully");
    } on DatabaseException {
      // If exception is thrown by database
      Fluttertoast.showToast(msg: "Not Updated");
    }
  }

  //Delete number from database using date.
  deleteNumber(Number item) async {
    final db = await database;
    try {
      //Query for deleting number from database
      db.delete("Number", where: "date = ?", whereArgs: [item.date]);
      Fluttertoast.showToast(msg: "Deleted Successfuly");
    } on DatabaseException {
      // If exception is thrown by database
      Fluttertoast.showToast(msg: "Not Deleted");
    }
  }

  // To clear the database
  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Number");
  }
}
