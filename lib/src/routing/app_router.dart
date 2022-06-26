import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/products_list/products_list_screen.dart';
import '../features/account/account_screen.dart';
import '../features/orders_list/orders_list_screen.dart';
import '../features/shopping_cart/shopping_cart_screen.dart';
import '../features/sign_in/email_password_sign_in_screen.dart';
import '../features/sign_in/email_password_sign_in_state.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          const ProductsListScreen(), // builder is nice if you want default transition
      routes: [
        GoRoute(
          path: 'cart',
          pageBuilder: (context, state) => MaterialPage(
            // if you want to customize transition use pageBuilder instead of builder
            key: state.pageKey,
            fullscreenDialog: true,
            child: const ShoppingCartScreen(),
          ),
        ),
        GoRoute(
          path: 'orders',
          pageBuilder: (context, state) => MaterialPage(
            // if you want to customize transition use pageBuilder instead of builder
            key: state.pageKey,
            fullscreenDialog: true,
            child: const OrdersListScreen(),
          ),
        ),
        GoRoute(
          path: 'account',
          pageBuilder: (context, state) => MaterialPage(
            // if you want to customize transition use pageBuilder instead of builder
            key: state.pageKey,
            fullscreenDialog: true,
            child: const AccountScreen(),
          ),
        ),
        GoRoute(
          path: 'signIn',
          pageBuilder: (context, state) => MaterialPage(
            // if you want to customize transition use pageBuilder instead of builder
            key: state.pageKey,
            fullscreenDialog: true,
            child: const EmailPasswordSignInScreen(
              formType: EmailPasswordSignInFormType.signIn,
            ),
          ),
        ),
      ],
    ),
  ],
  // turn off the # in the URLs on the web
  urlPathStrategy: UrlPathStrategy.path,
);
