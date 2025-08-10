import 'package:evently/app_theme.dart';
import 'package:evently/create_event_screen.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/nav_bar_icon.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/tabs/home/home_tab.dart';
import 'package:evently/tabs/love/love_tab.dart';
import 'package:evently/tabs/map/map_tab.dart';
import 'package:evently/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [HomeTab(), MapTab(), LoveTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        notchMargin: 5,
        shape: CircularNotchedRectangle(),
        color: settingsProvider.isDark
            ? AppTheme.backgroundDark
            : AppTheme.primary,
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
              label: AppLocalizations.of(context)!.home,
            ),
            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: 'map'),
              activeIcon: NavBarIcon(imageName: 'map_active'),
              label: AppLocalizations.of(context)!.map,
            ),
            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: 'love'),
              activeIcon: NavBarIcon(imageName: 'love_active'),
              label: AppLocalizations.of(context)!.love,
            ),
            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: 'profile'),
              activeIcon: NavBarIcon(imageName: 'profile_active'),
              label: AppLocalizations.of(context)!.profile,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CreateEventScreen.routeName);
        },
        child: Icon(Icons.add, size: 36),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
