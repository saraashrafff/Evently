class Onboarding {
  int index;
  String onboardingImageName;
  String onboardingText1;
  String onboardingText2;
  Onboarding({
    required this.index,
    required this.onboardingImageName,
    required this.onboardingText1,
    required this.onboardingText2,
  });
}

List<String> onboardingTexts1 = [
  'Personalize Your Experience',
  'Find Events That Inspire You',
  'Effortless Event Planning',
  'Connect with Friends & Share Moments',
];
List<String> onboardingTexts2 = [
  'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.',
  'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.',
  'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we\'ve got you covered. Plan with ease and focus on what matters - creating an unforgettable experience for you and your guests.',
  'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.',
];
List<Onboarding> onboardingPages = List.generate(
  onboardingTexts1.length,
  (index) => Onboarding(
    onboardingImageName: 'assets/images/onboarding_image_${index + 1}.png',
    onboardingText1: onboardingTexts1[index],
    onboardingText2: onboardingTexts2[index],
    index: index,
  ),
);
