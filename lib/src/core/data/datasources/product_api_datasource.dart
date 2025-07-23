import 'package:dio/dio.dart';
import 'package:pantry_app/src/core/api/api_constants.dart';
import 'package:pantry_app/src/core/models/product.dart';
import 'dart:convert';

class ProductApiDatasource {
  final Dio _dio;

  ProductApiDatasource(this._dio);

  Future<Product> fetchProduct(String barcode) async {
    try {
      final response = await _dio.get('${ApiConstants.products}/$barcode');

      if (response.statusCode == 200) {
        var result = jsonDecode(response.data);
        var product = result['product'];

        return Product.fromMap(product);
      } else {
        throw Exception('Failed to load product information');
      }
    } catch (e) {
      throw Exception('An error occured: $e');
    }
  }
}
