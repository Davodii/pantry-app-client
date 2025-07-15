import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pantry_app/data/models/product.dart';
import 'package:pantry_app/data/repositories/product_repository.dart';

class LocalProductRepository implements ProductRepository {
  @override
  Future<Product> getProduct(String barcode) async {
    // TODO: load the local json for this barcode

    // Load the JSON file from assets
    final String response = await rootBundle.loadString(
      'assets/json/product_data.json',
    );
    final data = await json.decode(response);

    return Product.fromMap(data);
  }
}
