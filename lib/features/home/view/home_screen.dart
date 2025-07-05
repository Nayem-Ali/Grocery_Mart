import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_mart/core/utils/logger/logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.manage_search_sharp, size: 35),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            // icon: Image.asset(AppIcons.cart),
            icon: Icon(CupertinoIcons.cart, size: 35),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
