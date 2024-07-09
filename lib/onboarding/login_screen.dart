import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_uganda/default_export.dart';
import 'package:explore_uganda/home/HomePage.dart';
import 'package:explore_uganda/onboarding/onboarding_export.dart';
import 'package:explore_uganda/onboarding/sign_out.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<dynamic> signInWithGoogle() async {
    showLoading();
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Sign In Error',
          text: 'Check your internet settings');
    }
  }

  showLoading() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Loggin in',
        text: 'Fetching your data');
  }

  Future<dynamic> emailPasswordAuth() async {
    showLoading();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'No related account',
            text: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Password error',
            text: 'Wrong password provided for that user.');
      }
    }
  }

  Future checkDocuement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (FirebaseAuth.instance.currentUser != null) {
      String docID = FirebaseAuth.instance.currentUser!.uid;
      final snapShot = await FirebaseFirestore.instance
          .collection('users')
          .doc(docID) // varuId in your case
          .get();

      if (snapShot.exists) {
        String? username = snapShot.data()!['username'];
        String? email = snapShot.data()!['email'];
        String? phoneNumber = snapShot.data()!['phoneNumber'];
        String? image = snapShot.data()!['image'];
        String? userId = FirebaseAuth.instance.currentUser!.uid;
        prefs.setString('username', username ?? '');
        prefs.setString('email', email ?? '');
        prefs.setString('phoneNumber', phoneNumber ?? '');
        prefs.setString('image', image ?? '');
        prefs.setString('userId', userId);
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Navigator.pushAndRemoveUntil(
            context,
            slideTransitionBuilder(
              const Homepage(),
            ),
            (_) => false);
      } else {
        signOutFromGoogle().whenComplete(() {
          Navigator.of(context, rootNavigator: true).pop('dialog');
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Signin error',
            text: 'Use the sign up screen.',
            onConfirmBtnTap: () {
              Navigator.push(
                context,
                fadeTransitionBuilder(
                  const SignUpPage(),
                ),
              );
            },
          );
        });
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'No related account',
        text: 'No user found for that email try signing up.',
        onConfirmBtnTap: () {
          Navigator.push(
            context,
            fadeTransitionBuilder(
              const SignUpPage(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: widths * 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Log In',
                    style: TextStyle(
                        color: Color(0xFFF3BC43),
                        fontSize: 37,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(
                      'Welcome Back.',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  CustomTextSignUpInput(
                    showObscurer: false,
                    labelText: 'Email',
                    hintText: 'Email',
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                  ),
                  CustomTextSignUpInput(
                    labelText: 'Password',
                    hintText: 'Password',
                    controller: passwordController,
                    textInputType: TextInputType.visiblePassword,
                  ),
                ],
              ),
              CustomTextButton(
                  text: 'Log In',
                  onPressed: () {
                    emailPasswordAuth().whenComplete(() {
                      checkDocuement();
                    });
                  }),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Space dividers evenly
                  children: [
                    Container(
                      color: const Color(
                          0xFFD9D9D9), // Adjust background color (optional)
                      width: MediaQuery.sizeOf(context).width / 3.5,
                      height: 1, // Expands to full width
                    ),
                    const Text(
                      "OR", // Change text as needed
                      style: TextStyle(
                        color: Color(0xFF1B1919),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      color: const Color(
                          0xFFD9D9D9), // Adjust background color (optional)
                      width: MediaQuery.sizeOf(context).width / 3.5,
                      height: 1, // Expands to full width
                    ),
                  ],
                ),
              ),
              CustomSignInButton(
                textLink: 'assets/images/onboarding/eu7.png',
                text: "Log in with Google",
                onPressed: () {
                  print('object');
                  signInWithGoogle().whenComplete(() {
                    checkDocuement();
                  });
                },
              ),
              CustomSignInButton(
                textLink: 'assets/images/onboarding/eu8.png',
                text: "Log in with Facebook",
                onPressed: () {
                  // Implement your sign in logic here
                },
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Don’t have an account?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            FontWeight.normal, // Underline for clickable look
                        color:
                            Color(0xFF1B1919), // Optional: change color on tap
                      ),
                    ),
                    TextSpan(
                      text: " Sign Up",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration
                            .underline, // Underline for clickable look
                        color:
                            Color(0xFFF3BC43), // Optional: change color on tap
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            fadeTransitionBuilder(
                              const SignUpPage(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
