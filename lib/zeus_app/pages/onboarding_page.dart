import 'package:dash/zeus_app/components/onboarding_card.dart';
import 'package:dash/zeus_app/pages/login_page.dart';
import 'package:dash/zeus_app/pages/old_login_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _onBoardingCards = [
    OnboardingCard(
      imageName: "lib/images/onboarding_1.png",
      title: 'Welcome to Sinau.io!',
      description:
          'Introducing the Learn.io platform and providing an overview of the application\'s purpose.',
      buttonText: 'Next',
      onPressed: (context) {
        _pageController.animateToPage(1,
            duration: Durations.long1, curve: Curves.linear);
      },
    ),
    OnboardingCard(
      imageName: "lib/images/onboarding_2.png",
      title: 'Welcome to Sinau.io!',
      description:
          'Introducing the Learn.io platform and providing an overview of the application\'s purpose.',
      buttonText: 'Next',
      onPressed: (context) {
        _pageController.animateToPage(2,
            duration: Durations.long1, curve: Curves.linear);
      },
    ),
    OnboardingCard(
      imageName: "lib/images/onboarding_3.png",
      title: 'Welcome to Sinau.io!',
      description:
          'Introducing the Learn.io platform and providing an overview of the application\'s purpose.',
      buttonText: 'Done',
      onPressed: (context) {
        //redirect to login
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: _onBoardingCards,
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: _onBoardingCards.length,
              effect: ExpandingDotsEffect(
                  activeDotColor: Theme.of(context).primaryColor),
              onDotClicked: (index) {
                _pageController.animateToPage(index,
                    duration: Durations.long1, curve: Curves.linear);
              },
            )
          ],
        ),
      ),
    );
  }
}
