import 'package:ecommerce_app/src/features/shopping_cart/shopping_cart_screen.dart';
import 'package:go_router/go_router.dart';

import '../features/products_list/products_list_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductsListScreen(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const ShoppingCartScreen(),
    ),
  ],
  // turn off the # in the URLs on the web
  urlPathStrategy: UrlPathStrategy.path,
);
