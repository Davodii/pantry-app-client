import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

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

    // For testing purposes, deletes the whole database on startup
    if (await databaseExists(path)) {
      await deleteDatabase(path);
      print('Database deleted!');
    }

    return await openDatabase(
      path,
      // Set the version. Executes onCreate function and provides a path
      // to perform database upgrades and downgrades.
      version: 1,
      onCreate: _onCreate,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON;');
        print('Foreign keys enabled.');
      },
      // TODO: add migration functions for data when changing the database version
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create the pantry table (id, name, quantity, expiration)
    // TODO: use csvsql to generate the correct headers needed (for beta)
    // TODO: add lastUsedDate field to products and propagate through project
    await db.execute('''
      CREATE TABLE $productsTable (
        barcode STRING PRIMARY KEY,
        name TEXT,
        genericName TEXT,
        ingredients TEXT,
        allergens TEXT,
        servingSize TEXT,
        servingQuantity TEXT,
        quantity TEXT,
        imageUrl TEXT)
    ''');

    await db.execute('''
      CREATE TABLE $pantryTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        barcode STRING,
        quantity TEXT, 
        expirationDate TEXT,
        FOREIGN KEY (barcode) REFERENCES products(barcode)
      )
    ''');

    await db.execute('''
      CREATE TABLE $groceryListTable (
        id INTEGER PRIMARY KEY,
        item TEXT, quantity TEXT,
        barcode STRING,
        FOREIGN KEY (barcode) REFERENCES products(barcode) 
      )
    ''');
  }
}
