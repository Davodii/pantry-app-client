import 'package:pantry_app/src/core/database/database_helper.dart';
import 'package:pantry_app/src/features/pantry/data/models/pantry_item.dart';
import 'package:pantry_app/src/core/models/product.dart';
import 'package:sqflite/sqflite.dart';

class PantryRepository {
  final dbProvider = DatabaseHelper();

  // TODO: TEST ALL OF THESE FUNCTIONS AND OPERATIONS ARE CORRECT

  Future<int> insertItem(
    String barcode,
    String quantity,
    String expirationDate,
  ) async {
    final Database db = await dbProvider.database;
    return db.insert(dbProvider.pantryTable, {
      "barcode": barcode,
      "quantity": quantity,
      "expirationDate": expirationDate,
    });
  }

  Future<int> removeItem(PantryItem item) async {
    final Database db = await dbProvider.database;

    return db.delete(
      dbProvider.pantryTable,
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> updateItem(
    PantryItem current,
    String barcode,
    String quantity,
    String expirationDate,
  ) async {
    final Database db = await dbProvider.database;

    return db.update(
      dbProvider.pantryTable,
      {
        "barcode": barcode,
        "quantity": quantity,
        "expirationDate": expirationDate,
      },
      where: 'id = ?',
      whereArgs: [current.id],
    );
  }

  Future<List<PantryItem>> getAllItems() async {
    final Database db = await dbProvider.database;

    final String pantry = dbProvider.pantryTable;
    final String products = dbProvider.productsTable;

    // Need to get all the items (along with products they refer to )
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT 
        $pantry.id,
        $pantry.quantity AS pantryQuantity,
        $pantry.expirationDate,
        $products.barcode,
        $products.name,
        $products.genericName,
        $products.ingredients,
        $products.allergens,
        $products.servingSize,
        $products.servingQuantity,
        $products.quantity AS productQuantity,
        $products.imageUrl
      FROM $pantry
      INNER JOIN $products ON $pantry.barcode = $products.barcode
      ''');

    return result.map((map) => _createPantryItem(map)).toList();
  }

  Future<List<PantryItem>> searchItemsByName(String name) async {
    final Database db = await dbProvider.database;

    final String pantry = dbProvider.pantryTable;
    final String products = dbProvider.productsTable;

    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT 
        $pantry.id,
        $pantry.quantity AS pantryQuantity,
        $pantry.expirationDate,
        $products.barcode,
        $products.name,
        $products.genericName,
        $products.ingredients,
        $products.allergens,
        $products.servingSize,
        $products.servingQuantity,
        $products.quantity AS productQuantity,
        $products.imageUrl
      FROM $pantry
      INNER JOIN $products ON $pantry.barcode = $products.barcode
      WHERE LOWER($products.name) LIKE LOWER('%$name%')
    ''');

    return result.map((map) => _createPantryItem(map)).toList();
  }

  PantryItem _createPantryItem(Map<String, dynamic> map) {
    {
      Product product = Product.fromMap({
        ...map,
        'quantity': map['productQuantity'],
      });

      return PantryItem.fromMap({
        ...map,
        'quantity': map['pantryQuantity'],
      }, product);
    }
  }
}
