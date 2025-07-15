// TODO: make object hold important information
// TODO: need to check the product CSV definition for this

class Product {
  final String barcode;
  // final String url; // url to OFF website
  final String? name;
  final String? genericName;
  final String? ingredients;
  final String? allergens;
  final String? servingSize;
  final String? servingQuantity;
  final String? quantity;
  final String? imageUrl;

  Product({
    required this.barcode,
    this.name,
    this.genericName,
    this.ingredients,
    this.allergens,
    this.servingSize,
    this.servingQuantity,
    this.quantity,
    this.imageUrl,
  });

  Map<String, Object?> toMap() {
    return {
      "barcode": barcode,
      "name": name,
      "genericName": genericName,
      "ingredients": ingredients,
      "allergens": allergens,
      "servingSize": servingSize,
      "servingQuantity": servingQuantity,
      "quantity": quantity,
      "imageUrl": imageUrl,
    };
  }

  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      barcode: json['barcode'],
      name: json['name'],
      genericName: json['genericName'],
      ingredients: json['ingredients'],
      allergens: json['allergens'],
      servingSize: json['servingSize'],
      servingQuantity: json['servingQuantity'],
      quantity: json['quantity'],
      imageUrl: json['imageUrl'],
    );
  }

  @override
  String toString() {
    return 'PantryItem('
        'barcode: $barcode,'
        'name: $name,'
        'genericName: $genericName,'
        'ingredients: $ingredients,'
        'allergens: $allergens,'
        'servingSize: $servingSize,'
        'servingQuantity: $servingQuantity,'
        'quantity: $quantity,'
        'imageUrl: $imageUrl'
        ')';
  }
}
