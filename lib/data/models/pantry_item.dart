class PantryItem {
  final int id;
  final String name;
  final int quantity;
  final DateTime? expiryDate;

  PantryItem({
    required this.id,
    required this.name,
    this.quantity = 1,
    this.expiryDate,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'expiryDate': expiryDate,
    };
  }

  @override
  String toString() {
    return 'PantryItem(id: $id, name: $name, quantity: $quantity, expiryDate: $expiryDate)';
  }
}
