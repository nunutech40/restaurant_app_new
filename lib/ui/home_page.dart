import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app_new/common/styles.dart';
import 'package:restaurant_app_new/ui/restaurant_bookmark_page.dart';
import 'package:restaurant_app_new/ui/restaurant_list_page.dart';
import 'package:restaurant_app_new/ui/settings_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  static const String _headlineText = 'Restaurants';

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const RestaurantBookmarkPage(),
    const SettingsPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.restaurant),
      label: _headlineText,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.bookmark),
      label: RestaurantBookmarkPage.bookmarksTitle,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: SettingsPage.settingsTitle,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
