import 'package:ecommerce_app/src/features/products_list/products_list_screen.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const ProductsListScreen(),
        ),
      ],
      // turn off the # in the URLs on the web
      urlPathStrategy: UrlPathStrategy.path,
    );
    return MaterialApp.router(
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      onGenerateTitle: (BuildContext context) => 'My Shop'.hardcoded,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.black, // background (button) color
            onPrimary: Colors.white, // foreground (text) color
          ),
        ),
      ),
    );
  }
}
