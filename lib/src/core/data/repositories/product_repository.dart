import 'package:pantry_app/src/core/database/db_provider.dart';
import 'package:pantry_app/src/core/data/models/product.dart';
import 'package:sqflite/sqlite_api.dart';

class ProductRepository {
  final dbProvider = DBProvider();

  // - [x] insert item
  // - [x] remove product
  // - [x] get all products

  // TODO: consider if need to update products
  // - update last used date for a product
  // - update product information ??? (maybe if the local version and server version are out of date)

  Future<int> insertProduct(Product product) async {
    final Database db = await dbProvider.database;

    return db.insert(dbProvider.productsTable, product.toMap());
  }

  Future<int> removeProduct(Product product) async {
    final Database db = await dbProvider.database;

    return db.delete(
      dbProvider.productsTable,
      where: 'barcode = ?',
      whereArgs: [product.barcode],
    );
  }

  Future<List<Product>> getAllProducts() async {
    final Database db = await dbProvider.database;

    List<Map<String, dynamic>> result = await db.query(
      dbProvider.productsTable,
    );

    return result.map((map) => Product.fromMap(map)).toList();
  }
}
