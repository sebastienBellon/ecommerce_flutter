import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
 * Product repository  with it's methods to retrieve async data
 * Future is used for REST API
 * Stream is used for websocket like stream connection
 */
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

/*
 * Provider using riverpod
 * watch is a method that allow to detect change in data
 * autoDispose : close stream connection when no widgets are listening anymore
 *  -> disposeDelay: specify a duration before closing the stream
 *  -> cacheTime : specify a duration until when the cached data are dropped
 * onDispose: callback to execute actions when the connection is dropped
 * family: way to register to a specific stream (passing input arguments to the provider)
 *  -> StreamProvider.family<"return type","argument type">(ref,"argument variable"){}
 */
final productsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
});

final productsListStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  debugPrint('created productsListStreamProvider');
  final productRepository = ref.watch(productsRepositoryProvider);
  return productRepository.watchProductList();
});

final productsListFutureProvider =
    FutureProvider.autoDispose<List<Product>>((ref) {
  final productRepository = ref.watch(productsRepositoryProvider);
  return productRepository.fetchProductList();
});

final productProvider = StreamProvider.family.autoDispose<Product?, String>(
  (ref, id) {
    debugPrint('created productProvider with id: $id');
    ref.onDispose(() => debugPrint('destroyed productProvider with id: $id'));
    final productRepository = ref.watch(productsRepositoryProvider);
    return productRepository.watchProduct(id);
  },
  disposeDelay: const Duration(seconds: 10),
  cacheTime: const Duration(seconds: 10),
);
