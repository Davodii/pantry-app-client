import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final DBProvider _instance = DBProvider._internal();
  factory DBProvider() => _instance;

  DBProvider._internal();

  Database? _database;

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
      version: 1,
      onCreate: _onCreate,
      // TODO: add migration functions for data when changing the database version
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    return db.execute(
      // Create the pantry table (id, name, quantity, expiration)
      // TODO: use csvsql to generate the correct headers needed (for beta)
      // TODO: create all tables (pantry, products, ...)
      'CREATE TABLE pantry_items (id INTEGER PRIMARY KEY, name TEXT, quantity INTEGER, expiryDate TEXT)',
    );
  }
}
