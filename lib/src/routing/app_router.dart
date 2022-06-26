import 'package:ecommerce_app/src/features/product_page/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ecommerce_app/src/features/products_list/products_list_screen.dart';
import 'package:ecommerce_app/src/features/account/account_screen.dart';
import 'package:ecommerce_app/src/features/orders_list/orders_list_screen.dart';
import 'package:ecommerce_app/src/features/shopping_cart/shopping_cart_screen.dart';
import 'package:ecommerce_app/src/features/sign_in/email_password_sign_in_screen.dart';
import 'package:ecommerce_app/src/features/sign_in/email_password_sign_in_state.dart';

enum AppRoute {
  home,
  cart,
  orders,
  account,
  signIn,
  product,
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) =>
          const ProductsListScreen(), // builder is nice if you want default transition
      routes: [
        GoRoute(
          path: 'cart',
          name: AppRoute.cart.name,
          pageBuilder: (context, state) => MaterialPage(
            // if you want to customize transition use pageBuilder instead of builder
            key: state.pageKey,
            fullscreenDialog: true,
            child: const ShoppingCartScreen(),
          ),
        ),
        GoRoute(
          path: 'orders',
          name: AppRoute.orders.name,
          pageBuilder: (context, state) => MaterialPage(
            // if you want to customize transition use pageBuilder instead of builder
            key: state.pageKey,
            fullscreenDialog: true,
            child: const OrdersListScreen(),
          ),
        ),
        GoRoute(
          path: 'account',
          name: AppRoute.account.name,
          pageBuilder: (context, state) => MaterialPage(
            // if you want to customize transition use pageBuilder instead of builder
            key: state.pageKey,
            fullscreenDialog: true,
            child: const AccountScreen(),
          ),
        ),
        GoRoute(
          path: 'signIn',
          name: AppRoute.signIn.name,
          pageBuilder: (context, state) => MaterialPage(
            // if you want to customize transition use pageBuilder instead of builder
            key: state.pageKey,
            fullscreenDialog: true,
            child: const EmailPasswordSignInScreen(
              formType: EmailPasswordSignInFormType.signIn,
            ),
          ),
        ),
        GoRoute(
          path: 'product/:id',
          name: AppRoute.product.name,
          builder: (context, state) {
            final productId = state.params['id']!; // for safety we had a null safety operator to indicate that id cannot be null
            return ProductScreen(productId: productId);
          },
        ),
      ],
    ),
  ],
  // turn off the # in the URLs on the web
  urlPathStrategy: UrlPathStrategy.path,
);
