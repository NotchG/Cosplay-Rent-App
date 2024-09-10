import 'package:cosplayrentapp/main.dart';
import 'package:cosplayrentapp/view/events_page.dart';
import 'package:cosplayrentapp/view/product_details_page.dart';
import 'package:cosplayrentapp/view/product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../view/home_page.dart';
import '../view/profile_page.dart';

class AppNavigation {
  AppNavigation._();

  static String initialRoute = "/home";

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _homeNavigatorKey = GlobalKey<NavigatorState>();
  static final _productNavigatorKey = GlobalKey<NavigatorState>();
  static final _eventsNavigatorKey = GlobalKey<NavigatorState>();
  static final _profileNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: initialRoute,
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                  path: "/home",
                  name: "Home",
                  builder: (context, state) => HomePage(
                    key: state.pageKey,
                  )
              ),
            ]
          ),
          StatefulShellBranch(
              navigatorKey: _eventsNavigatorKey,
              routes: [
                GoRoute(
                    path: "/events",
                    name: "Events",
                    builder: (context, state) => EventsPage(
                      key: state.pageKey,
                    )
                ),
              ]
          ),
          StatefulShellBranch(
              navigatorKey: _productNavigatorKey,
              routes: [
                GoRoute(
                    path: "/product",
                    name: "Product",
                    builder: (context, state) => ProductPage(
                      key: state.pageKey,
                    ),

                  routes: [
                    GoRoute(
                      path: ":productID",
                      builder: (context, state) => ProductDetailsPage(
                        productID: state.pathParameters['productID']!,
                      )
                    )
                  ]
                ),
              ]
          ),
          StatefulShellBranch(
              navigatorKey: _profileNavigatorKey,
              routes: [
                GoRoute(
                    path: "/profile",
                    name: "Profile",
                    builder: (context, state) => ProfilePage(
                      key: state.pageKey,
                      isSelf: true,
                    ),
                    routes: [
                      GoRoute(
                        path: ":profileID",
                        builder: (context, state) => ProfilePage(
                          profileID: state.pathParameters['profileID'],
                          key: state.pageKey,
                        ),
                      ),
                    ]
                ),
              ]
          ),
        ]
      )

    ]
  );
}