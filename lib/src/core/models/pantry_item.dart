import 'package:pantry_app/src/core/models/product.dart';
import 'package:pantry_app/src/core/models/quantity.dart';

class PantryItem {
  final int id;
  final Product product;
  final Quantity quantity;
  final DateTime? expirationDate;

  PantryItem({
    required this.id,
    required this.product,
    required this.quantity,
    this.expirationDate,
  });

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "barcode": product.barcode,
      "quantity": quantity.value,
      "expirationDate": expirationDate,
    };
  }

  factory PantryItem.fromMap(Map<String, dynamic> map, Product product) {
    return PantryItem(
      id: map['id'],
      product: product,
      quantity: Quantity(value: map['quantity']),
      expirationDate: map['expirationDate'] != null
          ? DateTime.tryParse(map['expirationDate'])
          : null,
    );
  }

  @override
  String toString() {
    return 'PantryItem(id: $id, barcode: ${product.barcode}, quantity: ${quantity.value}, expirationDate: $expirationDate)';
  }
}
