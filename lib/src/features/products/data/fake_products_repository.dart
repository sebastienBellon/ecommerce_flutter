import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';

class FakeProductsRepository {
  //Private constructor to avoid multiple objects creation
  FakeProductsRepository._();
  // singleton to avoid recreation of this object
  static FakeProductsRepository instance = FakeProductsRepository._();

  // method to retrieve data
  List<Product> getProductList() {
    return kTestProducts;
  }

  Product? getProduct(String id) {
    return kTestProducts.firstWhere((product) => product.id == id);
  }
}
