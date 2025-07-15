import 'package:pantry_app/data/models/product.dart';

abstract class ProductRepository {
  Future<Product> getProduct(String barcode);
}
