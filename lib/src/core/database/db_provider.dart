import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final DBProvider _instance = DBProvider._internal();
  factory DBProvider() => _instance;
  DBProvider._internal();

  Database? _database;
  final String pantryTable = 'pantry';
  final String productsTable = 'products';
  final String groceryListTable = 'grocery_list';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    final path = join(await getDatabasesPath(), 'pantry_app.db');

    return await openDatabase(
      path,
      // Set the version. Executes onCreate function and provides a path
      // to perform database upgrades and downgrades.
      version: 2,
      onCreate: _onCreate,
      // TODO: add migration functions for data when changing the database version
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    return db.execute(
      // Create the pantry table (id, name, quantity, expiration)
      // TODO: use csvsql to generate the correct headers needed (for beta)
      // TODO: add lastUsedDate field to products and propagate through project
      'CREATE TABLE $productsTable (barcode STRING PRIMARY KEY, name TEXT, genericName TEXT, ingredients TEXT, allergens TEXT, servingSize TEXT, servingQuantity TEXT, quantity TEXT, imageUrl TEXT);'
      'CREATE TABLE $pantryTable (id INTEGER PRIMARY KEY AUTOINCREMENT, barcode STRING FOREIGN KEY REFERENCES products(barcode), quantity TEXT, expirationDate TEXT);'
      'CREATE TABLE $groceryListTable (id INTEGER PRIMARY KEY, item TEXT, quantity TEXT, barcode STRING FOREIGN KEY REFERENCES products(barcode));',
    );
  }
}
