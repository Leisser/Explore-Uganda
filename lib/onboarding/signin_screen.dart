import 'dart:async';

import 'package:explore_uganda/default_export.dart';
import 'package:explore_uganda/onboarding/onboarding_export.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  var _timer;
  List images = [
    'assets/images/onboarding/eu3.png',
    'assets/images/onboarding/eu4.png',
    'assets/images/onboarding/eu5.png',
    'assets/images/onboarding/eu6.png',
  ];

  
  @override
  void initState() {
    super.initState();
    changepic();
    imageInt.addListener(
      () => changepic(),
    );
  }

  Future<void> changepic() async {
    _timer = Timer(const Duration(seconds: 3), () {
      if (imageInt.value == 0) {
        setState(() {
          imageInt.value = 1;
        });
      } else if (imageInt.value == 1) {
        setState(() {
          imageInt.value = 2;
        });
      } else if (imageInt.value == 2) {
        setState(() {
          imageInt.value = 3;
        });
      } else {
        setState(() {
          imageInt.value = 0;
        });
      }
    });
    _timer;
  }

  @override
  void dispose() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                images[imageInt.value],
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/onboarding/eu2.png'),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        fadeTransitionBuilder(
                          const LoginPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.sizeOf(context).width * .3,
                            vertical: 15),
                        // padding: EdgeInsets.fromLTRB(M, top, right, bottom),
                        backgroundColor: const Color(0xFFF3BC43)),
                    child: const Text(
                      ' Log In ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        fadeTransitionBuilder(
                          const SignUpPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).width * .3,
                          vertical: 15),
                      // padding: EdgeInsets.fromLTRB(M, top, right, bottom),

                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Continue as a Guest',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
