import 'package:expenzy/screens/main_screen.dart';
import 'package:expenzy/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  final bool showMainScreen;

  const Wrapper({
    super.key,
    required this.showMainScreen,
  });

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    // Navigate to MainScreen or OnboardingScreen based on showMainScreen
    return widget.showMainScreen
        ? const MainScreen()
        : const OnboardingScreen();
  }
}
