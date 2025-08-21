// TODO: make object hold important information
// TODO: need to check the product CSV definition for this

class Product {
  final int code;
  final String? name;
  final String? genericName;
  final String? ingredients;
  final String? allergens;
  final String? servingSize;
  final String? servingQuantity;
  final String? quantity;
  final String? imageUrl;

  Product({
    required this.code,
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
      "code": code,
      "name": name,
      "generic_name": genericName,
      "ingredients": ingredients,
      "allergens": allergens,
      "serving_size": servingSize,
      "serving_quantity": servingQuantity,
      "quantity": quantity,
      "image_url": imageUrl,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      code: map['code'] is int ? map['code'] : int.parse(map['code']),
      name: map['product_name'],
      genericName: map['generic_name'],
      ingredients: map['ingredients'],
      allergens: map['allergens'],
      servingSize: map['servingSize'],
      servingQuantity: map['serving_quantity'],
      quantity: map['quantity'],
      imageUrl: map['image_url'],
      // imageUrl: "",
    );
  }

  @override
  String toString() {
    return 'Product('
        'code: $code,'
        'name: $name,'
        'generic_name: $genericName,'
        'ingredients: $ingredients,'
        'allergens: $allergens,'
        'serving_size: $servingSize,'
        'serving_quantity: $servingQuantity,'
        'quantity: $quantity,'
        'image_url: $imageUrl'
        ')';
  }
}
