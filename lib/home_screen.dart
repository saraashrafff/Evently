import 'package:evently/app_theme.dart';
import 'package:evently/nav_bar_icon.dart';
import 'package:evently/tabs/home/home_tab.dart';
import 'package:evently/tabs/love/love_tab.dart';
import 'package:evently/tabs/map/map_tab.dart';
import 'package:evently/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [HomeTab(), MapTab(), LoveTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        notchMargin: 5,
        shape: CircularNotchedRectangle(),
        color: AppTheme.primary,
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (index) {
            if (currentIndex == index) {
              return;
            } else {
              currentIndex = index;
              setState(() {});
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: 'home'),
              activeIcon: NavBarIcon(imageName: 'home_active'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: 'map'),
              activeIcon: NavBarIcon(imageName: 'map_active'),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: 'love'),
              activeIcon: NavBarIcon(imageName: 'love_active'),
              label: 'Love',
            ),
            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: 'profile'),
              activeIcon: NavBarIcon(imageName: 'profile_active'),
              label: 'Profile',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, size: 36),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
