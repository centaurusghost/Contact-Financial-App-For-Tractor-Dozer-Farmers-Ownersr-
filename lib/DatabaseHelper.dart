import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:clean_app/Contact.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;
  static const _databaseName = 'ContactData.db';
  static const _databaseVersion = 1;
  static Database _database;
  String tblContact = 'contact_table'; //contact table
  String colId = 'id';
  String colName = 'name';
  String colPhone = 'phone';
  String colTime = 'time';
  String colCostPerHour = 'costperhour';
  String colPaidAmount = 'piadamount';
  String colTotal = 'total';
  String colRemaining = 'remaining';

  DatabaseHelper._createInstance();
//named constructor to create instance of database helper


  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
      return _databaseHelper;
    }
    return _databaseHelper;
  }
  Future<Database> initializeDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initializeDatabase();
    return _database;
  }


  _onCreateDB(Database db, int version) async {
    await db.execute('''
     CREATE TABLE ${Contact.tblContact}(
     ${Contact.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
     ${Contact.colName} TEXT NOT NULL,
     ${Contact.colPhone} TEXT,
     ${Contact.colTime} TEXT NOT NULL ,
     ${Contact.colCostPerHour} TEXT NOT NULL,
     ${Contact.colPaidAmount} TEXT NOT NULL,
     ${Contact.colTotal} TEXT NOT NULL,
     ${Contact.colRemaining} TEXT NOT NULL
        ) 
   ''');
    //for testing only few values are not null or null
  }

  Future<int> insertContact(Contact contact) async {
    print("insert contact called");
    Database db = await database;
    var result =await db.insert(Contact.tblContact, contact.toMap());
    return result;
  }
//to update detalis of contatc
  Future<int> updateContact(Contact contact) async {
    print("update contact called");
    Database db = await database;
     var result =  await db.update(Contact.tblContact, contact.toMap(),
        where: '${Contact.colId}=?', whereArgs: [contact.id]);
    return result;
  }
//to delete contact
  Future<int> deleteContact(int id) async {
    Database db = await database;
    var result =  await db.delete(Contact.tblContact,
        where: '${Contact.colId}=?', whereArgs: [id]);
    return result;
  }
//to get count
  Future<int> getCount() async{
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $tblContact');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

//to list all data
  Future<List<Contact>> fetchContact() async {
    Database db = await database;
    List<Map> contacts = await db.query(Contact.tblContact);
    var result = contacts.length == 0
        ? []
        : contacts.map((e) => Contact.fromMap(e)).toList();
    return result;
  }


}
final databaseHelper = DatabaseHelper();