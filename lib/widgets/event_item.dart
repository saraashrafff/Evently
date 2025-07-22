import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/meeting.png',
            height: screenSize.height * 0.23,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                '21',
                style: textTheme.titleLarge!.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Nov',
                style: textTheme.titleSmall!.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          width: screenSize.width - 32,
          bottom: 8,
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Meeting for Updating The Development Method Meeting for Updating The Development Method Meeting for Updating The Development Method  ',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall!.copyWith(
                      color: AppTheme.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.favorite_rounded,
                    color: AppTheme.primary,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
