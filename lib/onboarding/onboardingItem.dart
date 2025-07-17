import 'package:evently/app_theme.dart';
import 'package:evently/onboarding/onboarding.dart';
import 'package:flutter/material.dart';

class OnboardingItem extends StatelessWidget {
  Onboarding onboarding;
  int index;
  VoidCallback? onTap;
  OnboardingItem({
    super.key,
    required this.onboarding,
    required this.index,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Image.asset(
            'assets/images/onboarding_image_${onboarding.index + 1}.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 28),
          Text(
            onboarding.onboardingText1,
            style: textTheme.titleMedium!.copyWith(color: AppTheme.primary),
          ),
          SizedBox(height: 28),
          Text(
            onboarding.onboardingText2,
            style: textTheme.titleSmall!.copyWith(
              color: AppTheme.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
