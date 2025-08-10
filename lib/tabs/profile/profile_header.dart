import 'package:evently/app_theme.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(64),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Image.asset(
              'assets/images/route_logo.png',

              height: MediaQuery.sizeOf(context).height * 0.12,
              fit: BoxFit.fill,
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Provider.of<UserProvider>(context).currentUser!.name,
                  style: textTheme.headlineSmall,
                ),
                SizedBox(height: 10),
                Text(
                  Provider.of<UserProvider>(context).currentUser!.email,
                  style: textTheme.titleMedium!.copyWith(color: AppTheme.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
