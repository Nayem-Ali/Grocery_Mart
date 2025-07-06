import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_mart/core/utils/logger/logger.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

        currentIndex: widget.navigationShell.currentIndex,
        onTap: (index) {
          try {
            widget.navigationShell.goBranch(
              index,
              initialLocation: index == widget.navigationShell.currentIndex,
            );
            // print(index);
            // print(index == widget.navigationShell.currentIndex);
          } catch (e) {
            debug(e);
          }
        },
        useLegacyColorScheme: true,
        items: [
          BottomNavigationBarItem(
            // icon: Image.asset(AppIcons.exploreProducts),
            icon: Icon(Icons.home, size: 25),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            // icon: Image.asset(AppIcons.exploreProducts),
            icon: Icon(Icons.manage_search_sharp, size: 25),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            // icon: Image.asset(AppIcons.cart),
            icon: Icon(CupertinoIcons.cart, size: 25),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
