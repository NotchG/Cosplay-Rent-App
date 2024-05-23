import 'package:cosplayrentapp/MockData/Catalogue.dart';
import 'package:cosplayrentapp/pages/Product%20Page/productPage.dart';
import 'package:cosplayrentapp/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MockDatabase mock = MockDatabase();
  mock.getData();

  final routes = GoRouter(
      routes: [
        GoRoute(
            path: "/",
            builder: (context, state) => HomePage(
              data: mock,
            )
        ),
        GoRoute(
            path: "/product/:productID",
            builder: (context, state) => ProductPage(
              productID: state.pathParameters['productID'],
              data:mock
            )
        )
      ]
  );
  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routes,
    )
  );
}
