import 'package:pantry_app/data/models/pantry_item.dart';
import 'package:pantry_app/data/store/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class PantryItemRepository {
  final dbProvider = DBProvider();

  Future<void> insertPantryItem(PantryItem item) async {
    final db = await dbProvider.database;

    await db.insert(
      'pantry',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PantryItem>> pantryItems() async {
    final db = await dbProvider.database;

    final List<Map<String, Object?>> pantryItemMaps = await db.query('pantry');

    return [
      for (final {
            'id': id as int,
            'name': name as String,
            'quantity': quantity as int,
            'expiryDate': expiryDate as String,
          }
          in pantryItemMaps)
        PantryItem(
          id: id,
          name: name,
          quantity: quantity,
          expiryDate: DateTime.tryParse(expiryDate),
        ),
    ];
  }
}
