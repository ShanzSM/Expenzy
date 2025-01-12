import 'package:expenzy/models/onboarding_model.dart';

class OnboardingData {
  static final List<Onboarding> onboardingDataList = [
    Onboarding(
        title: "Gain total control of your money",
        imagepath: "assets/images/onboard_1.png",
        description: "Become your own money manager and make every cent count"),
    Onboarding(
        title: "Know where your money goes",
        imagepath: "assets/images/onboard_2.png",
        description:
            "Track your transaction easilywith categories and financial report "),
    Onboarding(
        title: "Planning ahead",
        imagepath: "assets/images/onboard_3.png",
        description: "Setup your budget for each categoryso you in control")
  ];
}
