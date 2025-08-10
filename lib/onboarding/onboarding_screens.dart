import 'package:evently/app_theme.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/onboarding/onboarding.dart';
import 'package:evently/onboarding/onboardingItem.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreens extends StatefulWidget {
  static const routeName = 'onboarding';

  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  PageController pageController = PageController();
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1);
    currentIndex = 1;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/on_boarding_header.png',
              width: double.infinity,
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) => OnboardingItem(
                  onboarding: onboardingPages[index + 1],
                  index: index,
                  onTap: goToNextPage,
                ),
                itemCount: onboardingPages.length - 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentIndex > 0
                      ? IconButton.outlined(
                          onPressed: () {
                            goToPreviousPage();
                          },
                          icon: Icon(Icons.arrow_back, color: AppTheme.primary),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppTheme.primary),
                          ),
                        )
                      : SizedBox(width: 50),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: onboardingPages.length - 1,
                    effect: WormEffect(
                      dotHeight: 7,
                      dotWidth: 7,
                      dotColor: AppTheme.black,
                      activeDotColor: AppTheme.primary,
                    ),
                  ),
                  IconButton.outlined(
                    onPressed: () {
                      currentIndex == onboardingPages.length - 2
                          ? finishOnBoarding()
                          : goToNextPage();
                    },
                    icon: Icon(Icons.arrow_forward, color: AppTheme.primary),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppTheme.primary),
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

  void goToNextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void goToPreviousPage() {
    pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> finishOnBoarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstRun', false);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
