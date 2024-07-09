// import 'package:explore_uganda/default_export.dart';
// import 'package:explore_uganda/home/HomePage.dart';

// import '../animated_intro/animated_introduction.dart';
// import 'package:flutter/material.dart';

// final List<SingleIntroScreen> pages = [
//   const SingleIntroScreen(
//     imageWithBubble: false,
//     title: 'Did you know?',
//     description:
//         'Uganda has over 1000 species of birds making it a heaven for birdwatchers. With a percentage of 68% of the continent and 12% of the total population in the world. Awesome right?',
//     imageAsset: 'assets/images/onboarding/eu9.png',
//   ),
//   const SingleIntroScreen(
//     imageWithBubble: false,
//     title: 'Did you know?',
//     description:
//         'Uganda is blessed to have more than 165 lakes including Lake Victoria the second largest freshwater lake, 14 waterfalls and 8 major rivers and including the source of the Nile',
//     imageAsset: 'assets/images/onboarding/eu4.png',
//   ),
//   const SingleIntroScreen(
//     imageWithBubble: false,
//     title: 'Did you know?',
//     description:
//         'Uganda is home to over 736 different cultures and has over 5 dominant regions',
//     imageAsset: 'assets/images/onboarding/eu6.png',
//   ),
// ];

// /// Example page
// class OnboardingSlidePage extends StatelessWidget {
//   const OnboardingSlidePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: AnimatedIntroduction(
//           topHeightForFooter: heights * 40,
//           footerRadius: 120,
//           slides: pages,
//           indicatorType: IndicatorType.circle,
//           textColor: Colors.black,
//           activeDotColor: Colors.grey,
//           footerBgColor: Colors.white,
//           doneText: "Finish",
//           isFullScreen: true,
//           viewPortFraction: 100,
//           onDone: () {
//            Navigator.pushAndRemoveUntil(
//           context,
//           slideTransitionBuilder(
//             const Homepage(),
//           ),
//           (_) => false);
//           },
//         ),
//       ),
//     );
//   }
// }
