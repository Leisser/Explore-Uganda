import 'package:flutter/material.dart';

import '../home/HomePage.dart';
import '../reusables/custon_container.dart';
import '../route_animations/route_animations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<OnboardingSlide> _slides = [
    OnboardingSlide(
      title: 'Did you know?',
      description:
          'Uganda has over 1000 species of birds making it a heaven for birdwatchers. With a percentage of 68% of the continent and 12% of the total population in the world. Awesome right?',
      imageUrl: 'assets/images/onboarding/eu9.png',
      backgroundColor: Colors.blue,
    ),
    OnboardingSlide(
      title: 'Did you know?',
      description:
          'Uganda is blessed to have more than 165 lakes including Lake Victoria the second largest freshwater lake, 14 waterfalls and 8 major rivers and including the source of the Nile',
      imageUrl: 'assets/images/onboarding/eu4.png',
      backgroundColor: Colors.green,
    ),
    OnboardingSlide(
      title: 'Did you know?',
      description:
          'Uganda is home to over 736 different cultures and has over 5 dominant regions',
      imageUrl: 'assets/images/onboarding/eu6.png',
      backgroundColor: Colors.orange,
    ),
  ];

  void _nextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _previousPage() {
    _pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemCount: _slides.length,
          itemBuilder: (context, index) => _buildSlide(_slides[index]),
        ),
      ),
    );
  }

  Widget _buildSlide(OnboardingSlide slide) {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(slide.imageUrl!), fit: BoxFit.cover)),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 2 / 3,
              ),
              SizedBox(
                width: double.infinity,
                child: CustomPaint(
                  painter: RPSCustomPainter(),
                  size: Size(
                      double.infinity, MediaQuery.sizeOf(context).height / 3),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20.0),
                        Text(
                          slide.title,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          slide.description,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 20.0),
                        _buildNavigationButtons()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                slideTransitionBuilder(
                  const Homepage(),
                ),
                (_) => false);
          },
          child: const Text('Skip'),
        ),
        _buildIndicatorRow(),
        if (_currentPage == _slides.length - 1)
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  slideTransitionBuilder(
                    const Homepage(),
                  ),
                  (_) => false);
            },
            child: const Text('Done'),
          ),
        if (_currentPage < _slides.length - 1)
          InkWell(
            onTap: _nextPage,
            child: const Text('Next'),
          ),
      ],
    );
  }

  Widget _buildIndicatorRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _slides.asMap().entries.map((entry) {
          final int index = entry.key;
          final isActive = index == _currentPage;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            width: isActive ? 20.0 : 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.grey,
              borderRadius: BorderRadius.circular(5.0),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class OnboardingSlide {
  final String title;
  final String description;
  final String? imageUrl; // Optional image URL
  final Color backgroundColor;

  OnboardingSlide({
    required this.title,
    required this.description,
    this.imageUrl,
    required this.backgroundColor,
  });
}
