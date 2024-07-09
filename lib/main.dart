import 'dart:async';
import 'package:explore_uganda/firebase_options.dart';
import 'package:explore_uganda/home/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'onboarding/onboarding_export.dart';

import 'package:flutter/material.dart';
import 'default_export.dart';
import 'services/notificationService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ExploreApp());
}

class ExploreApp extends StatelessWidget {
  const ExploreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF3BC43)),
        useMaterial3: true,
      ),
      home: const ExplorePage(),
    );
  }
}

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  // void getToken() {
  //   FirebaseMessaging.instance.getToken().then((value) {
  //     print("TOKEN IS :: :: $value");
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // getToken();
    nextScreenNav();
  }

  Future<void> nextScreenNav() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (FirebaseAuth.instance.currentUser != null) {
      Timer(const Duration(seconds: 5), () {
        Navigator.push(
          context,
          fadeTransitionBuilder(
            const Homepage(),
          ),
        );
        prefs.setString('user_state', 'user');
      });
    } else {
      Timer(const Duration(seconds: 5), () {
        Navigator.pushAndRemoveUntil(
            context,
            fadeTransitionBuilder(
              const SigninScreen(),
            ),
            (_) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/onboarding/eu1.png'),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 1,
                ),
                Image.asset('assets/images/onboarding/eu2.png'),
                const SizedBox(
                  child: Column(
                    children: [
                      Text(
                        'All Rights Reserved 2024 ®',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton: Row(
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: <Widget>[
        //     FloatingActionButton(
        //       child: const Icon(Icons.add),
        //       onPressed: () => context.read<ExploreCubit>().increment(),
        //     ),
        //     const SizedBox(height: 4),
        //     FloatingActionButton(
        //       child: const Icon(Icons.remove),
        //       onPressed: () => context.read<ExploreCubit>().decrement(),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
