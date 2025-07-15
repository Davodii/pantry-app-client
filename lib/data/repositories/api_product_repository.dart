import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pantry_app/data/models/product.dart';
import 'package:pantry_app/data/repositories/product_repository.dart';

class ApiProductRepository extends ProductRepository {
  final String _baseUrl = 'https://api.example.com';

  @override
  Future<Product> getProduct(String barcode) async {
    final response = await http.get(Uri.parse('$_baseUrl/products/$barcode'));

    if (response.statusCode == 200) {
      return Product.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }
}
