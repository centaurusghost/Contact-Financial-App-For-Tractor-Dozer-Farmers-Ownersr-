import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:clean_app/Contact.dart';

class DatabaseHelper {
  static const _databaseName = 'ContactData.db';
  static const _databaseVersion = 1;

  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();
  Database _database;

  Future<Database> get database async{
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute('''
     CREATE TABLE ${Contact.tblContact}(
     ${Contact.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
     ${Contact.colName} TEXT NOT NULL,
     ${Contact.colPhone} TEXT,
     ${Contact.colTime} TEXT NOT NULL,
     ${Contact.colCostPerHour} TEXT NOT NULL,
     ${Contact.colPaidAmount} TEXT NOT NULL,
     ${Contact.colTotal} TEXT,
     ${Contact.colRemaining} TEXT 
        ) 
   ''');
  }
  Future<int> insertContact(Contact contact) async {
   Database db = await database;
  return await db.insert(Contact.tblContact, contact.toMap());
  }



}
