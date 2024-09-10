import 'package:cosplayrentapp/navigation/app_navigation.dart';
import 'package:cosplayrentapp/view/product_details_page.dart';
import 'package:cosplayrentapp/view/profile_page.dart';
import 'package:cosplayrentapp/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppNavigation.router,
      theme: _buildTheme(Brightness.light),
    )
  );
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.ralewayTextTheme(baseTheme.textTheme),
  );
}

class MainWrapper extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainWrapper({super.key, required this.navigationShell});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int selectedIndex = 0;

  void goToBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Color(0xff232323),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: Color(0xff232323),
            ),
            icon: Icon(
                Icons.home,
              color: Colors.white,
            ),
            label: 'Home'
          ),
          NavigationDestination(
              selectedIcon: Icon(
                Icons.calendar_month,
                color: Color(0xff232323),
              ),
              icon: Icon(
                Icons.calendar_month,
                color: Colors.white,
              ),
              label: 'Events'
          ),
          NavigationDestination(
              selectedIcon: Icon(
                Icons.shopping_cart_outlined,
                color: Color(0xff232323),
              ),
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
              label: 'Products'
          ),
          NavigationDestination(
              selectedIcon: Icon(
                Icons.person_outlined,
                color: Color(0xff232323),
              ),
              icon: Icon(
                Icons.person_outlined,
                color: Colors.white,
              ),
              label: 'Profile'
          )
        ],
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
          goToBranch(selectedIndex);
        },
        selectedIndex: selectedIndex,
      ),
    );
  }
}

