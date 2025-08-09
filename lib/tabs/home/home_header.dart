import 'package:evently/app_theme.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatefulWidget {
  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider = Provider.of<EventProvider>(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: settingsProvider.isDark
            ? AppTheme.backgroundDark
            : AppTheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.only(bottom: 16, left: 16),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Back ✨', style: textTheme.titleSmall),
            Text(
              Provider.of<UserProvider>(context).currentUser!.name,
              style: textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            DefaultTabController(
              length: CategoryModel.categories.length + 1,
              child: TabBar(
                labelPadding: EdgeInsets.only(right: 10, left: 0),
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                onTap: (index) {
                  if (currentIndex == index) return;
                  currentIndex = index;
                  CategoryModel? selectedCategory = currentIndex == 0
                      ? null
                      : CategoryModel.categories[currentIndex - 1];
                  eventProvider.filterEvents(selectedCategory);
                  setState(() {});
                },
                tabs: [
                  TabItem(
                    label: 'All',
                    icon: Icons.category,
                    isSelected: currentIndex == 0,
                    selectedForegroundColor: settingsProvider.isDark
                        ? AppTheme.white
                        : AppTheme.primary,
                    unSelectedForegroundColor: AppTheme.white,
                    selectedBackgroundColor: settingsProvider.isDark
                        ? AppTheme.primary
                        : AppTheme.white,
                  ),
                  ...CategoryModel.categories.map(
                    (category) => TabItem(
                      label: category.name,
                      icon: category.icon,
                      isSelected:
                          currentIndex ==
                          CategoryModel.categories.indexOf(category) + 1,
                      selectedForegroundColor: settingsProvider.isDark
                          ? AppTheme.white
                          : AppTheme.primary,
                      unSelectedForegroundColor: AppTheme.white,
                      selectedBackgroundColor: settingsProvider.isDark
                          ? AppTheme.primary
                          : AppTheme.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
