import 'package:dio/dio.dart';
import 'package:pantry_app/src/core/api/api_constants.dart';
import 'package:pantry_app/src/core/models/product.dart';

class ProductApiDatasource {
  final Dio _dio;

  ProductApiDatasource(this._dio);

  Future<Product> fetchProduct(String barcode) async {
    try {
      final response = await _dio.get('${ApiConstants.products}/$barcode');
      print('✅ - Response gotten with barcode $barcode');

      if (response.statusCode == 200) {
        print('✅ - Recived valid information (Code 200)');
        print(response.data);
        var data = response.data;
        print('✅ - Decoded JSON data');
        var productData = data['product'];
        print('✅ - Decoded product map');

        productData['ingredients'] = 'ingredients';
        productData['allergens'] = 'allergens';

        var product = Product.fromMap(productData);
        print("✅ - Created Product");
        return product;
      } else {
        throw Exception('Failed to load product information');
      }
    } catch (e) {
      throw Exception('An error occured: $e');
    }
  }
}
