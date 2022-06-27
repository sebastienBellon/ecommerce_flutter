import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductsRepository {
  final List<Product> _products = kTestProducts;

  // method to retrieve data
  List<Product> getProductList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductList() async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_products);
    // throw Exception('Connection failed');
  }

  Stream<List<Product>> watchProductList() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield _products;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductList()
        .map((product) => product.firstWhere((product) => product.id == id));
  }
}

final productsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
});

final productsListStreamProvider = StreamProvider<List<Product>>((ref) {
  final productRepository = ref.watch(productsRepositoryProvider);
  return productRepository.watchProductList();
});

final productsListFutureProvider = FutureProvider<List<Product>>((ref) {
  final productRepository = ref.watch(productsRepositoryProvider);
  return productRepository.fetchProductList();
});

final productProvider = StreamProvider.family<Product?, String>((ref, id) {
  final productRepository = ref.watch(productsRepositoryProvider);
  return productRepository.watchProduct(id);
});
