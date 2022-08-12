import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/screens/cart.dart';
import 'package:grocery/providers/dark_theme_provider.dart';
import 'package:grocery/screens/home.dart';
import 'package:grocery/screens/user.dart';
import 'package:grocery/services/utils.dart';
import 'package:provider/provider.dart';

import 'categories.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List _pages = [
    const HomeScreen(),
    CategoriesScreen(),
    const CartScreen(),
    const UserScreen(),
  ];
  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: themeState.getDarkTheme
            ? Theme.of(context).cardColor
            : Colors.white,
        selectedItemColor:
            themeState.getDarkTheme ? Colors.blue[900] : Colors.blue,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _selectedPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:
                Icon(_selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1
                ? IconlyBold.category
                : IconlyLight.category),
            label: "Catagories",
          ),
          BottomNavigationBarItem(
            icon: Badge(
              toAnimate: true,
              shape: BadgeShape.circle,
              badgeColor: Utils(context).orangeColor,
              badgeContent: const FittedBox(child: Text('1')),
              child: Icon(
                _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy,
              ),
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 3 ? IconlyBold.profile : IconlyLight.profile),
            label: "User",
          ),
        ],
      ),
    );
  }
}
