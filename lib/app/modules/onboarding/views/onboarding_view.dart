import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: [
          PageViewModel(
            useScrollView: false,
            titleWidget: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 40,
                ),
              ],
            ),
            body: "Find your perfect pet match with us!",
            footer: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Center(
                child: Lottie.network(
                  "https://lottie.host/1cf530b8-b499-452a-81ac-85cc0abd3d1d/3WkC0QDveM.json",
                ),
              ),
            ),
          ),
          PageViewModel(
            useScrollView: false,
            title: "Browse Pets",
            body: "Explore a wide variety of pets available for adoption.",
            footer: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Lottie.network(
                  'https://lottie.host/e39b7aa3-3038-4d4d-a5e5-4143dd79f9c2/pScYyyeWlI.json'),
            ),
          ),
          PageViewModel(
            useScrollView: false,
            title: "Adopt Your Best Friend",
            body: "Find your new best friend and give them a loving home.",
            footer: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Lottie.network(
                  'https://lottie.host/bafaaf02-99b6-45a7-b911-ba8f15105086/azQ7Jx5cVy.json'),
            ),
          ),
        ],
        showDoneButton: false,
        showSkipButton: false,
        showNextButton: false,
        showBackButton: false,
        scrollPhysics: const BouncingScrollPhysics(),
        dotsDecorator: const DotsDecorator(
          size: Size(8.0, 8.0),
          activeSize: Size(22.0, 8.0),
          activeColor: Colors.lightBlueAccent,
          color: Colors.grey,
          spacing: EdgeInsets.symmetric(horizontal: 4.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        globalFooter: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed('/auth'); // Navigate to Sign In page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
