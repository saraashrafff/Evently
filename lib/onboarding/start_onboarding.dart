import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/onboarding/onboarding.dart';
import 'package:evently/onboarding/onboardingItem.dart';
import 'package:evently/onboarding/onboarding_screens.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:flutter/material.dart';

class StartOnboarding extends StatelessWidget {
  static const routeName = '/';

  const StartOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/on_boarding_header.png',
              width: double.infinity,
            ),
            OnboardingItem(onboarding: onboardingPages[0], index: 0),
            Spacer(),
            DefaultElevatedButton(
              label: AppLocalizations.of(context)!.letsStart,
              style: Theme.of(context).textTheme.titleLarge,
              onPressed: () {
                Navigator.of(
                  context,
                ).pushReplacementNamed(OnboardingScreens.routeName);
              },
            ),
            SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
