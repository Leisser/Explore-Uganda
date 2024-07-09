import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_uganda/default_export.dart';
import 'package:explore_uganda/onboarding/onboarding_export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quickalert/quickalert.dart';

import 'onboarding_change.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  showLoading() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Loggin in',
        text: 'Fetching your data');
  }

  saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (FirebaseAuth.instance.currentUser != null) {
      String? username = userNameController.text;
      String? email = emailController.text;
      String? phoneNumber = phoneController.text;
      String? password = passwordController.text;
      String? image = '';
      String? userId = FirebaseAuth.instance.currentUser!.uid;
      prefs.setString('username', username);
      prefs.setString('email', email);
      prefs.setString('phoneNumber', phoneNumber);
      prefs.setString('password', password);
      prefs.setString('image', image);
      prefs.setString('userId', userId);
      checkDocuement(userId, username, email, phoneNumber, image);
    }
  }

  savegoogleData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (FirebaseAuth.instance.currentUser != null) {
      String? username = FirebaseAuth.instance.currentUser!.displayName;
      String? email = FirebaseAuth.instance.currentUser!.email;
      String? phoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
      String? image = FirebaseAuth.instance.currentUser!.photoURL;
      String? userId = FirebaseAuth.instance.currentUser!.uid;
      prefs.setString('username', username!);
      prefs.setString('email', email!);
      prefs.setString('phoneNumber', phoneNumber ?? '');
      prefs.setString('image', image!);
      prefs.setString('userId', userId);
      checkDocuement(userId, username, email, phoneNumber, image);
    } else {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Sign In Error',
        text: 'Check your internet connection',
      );
    }
    
  }

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
        text: 'Check your internet connection',
      );
    }
  }

  Future<dynamic> emailPasswordAuth() async {
    showLoading();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Weak Password',
          text:
              '''The password provided is too weak.Recommended passwords contain at least 8 characters, one uppercase,
one lowercase, one number, and one special character''',
        );
      } else if (e.code == 'email-already-in-use') {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Account already exists',
            text: 'The account already exists for that email.');
      } else {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Sign in problem',
            text: 'Cross check your email or internet connection.');
      }
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Sign in problem',
          text: 'Cross check your email or internet connection.');
    }
  }

  Future checkDocuement(
      String docID, username, email, phoneNumber, image) async {
    final snapShot =
        await FirebaseFirestore.instance.collection('users').doc(docID).get();

    if (!snapShot.exists) {
      DocumentReference reference =
          FirebaseFirestore.instance.collection('users').doc(docID);
      await reference.set({
        "username": username,
        "email": email,
        "phoneNumber": phoneNumber,
        "image": image,
        "userId": docID,
        "isAdmin": false,
      });
      Navigator.of(context, rootNavigator: true).pop('dialog');
      Navigator.pushAndRemoveUntil(
          context,
          slideTransitionBuilder(
            const OnboardingScreen(),
          ),
          (_) => false);
    } else {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      Navigator.pushAndRemoveUntil(
          context,
          slideTransitionBuilder(
            const OnboardingScreen(),
          ),
          (_) => false);
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
                    'Sign Up',
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
                      'Hello, Welcome to Explore Uganda',
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
                    labelText: 'Username',
                    hintText: 'Username',
                    controller: userNameController,
                    textInputAction: TextInputAction.next,
                  ),
                  CustomTextSignUpInput(
                    showObscurer: false,
                    labelText: 'Email Address',
                    hintText: 'Email Address',
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  CustomTextSignUpInput(
                    showObscurer: false,
                    labelText: 'Phone Number',
                    hintText: 'Phone Number',
                    controller: phoneController,
                    textInputType: TextInputType.phone,
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
                text: "Sign Up with Google",
                onPressed: () {
                  if (_isChecked == true) {
                    signInWithGoogle().whenComplete(savegoogleData);
                  } else {
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Terms and Conditions',
                        text:
                            'You need to read, understand and accept terms and conditions to proceed');
                  }
                },
              ),
              CustomSignInButton(
                textLink: 'assets/images/onboarding/eu8.png',
                text: "Sign Up with Facebook",
                onPressed: () {
                  // Implement your sign in logic here
                },
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (newValue) {
                      setState(() {
                        _isChecked = newValue!; // Pass the changed value
                      });
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "I agree with the ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight
                                .normal, // Underline for clickable look
                            color: Color(
                                0xFF1B1919), // Optional: change color on tap
                          ),
                        ),
                        TextSpan(
                          text: "terms and conditions",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration
                                .underline, // Underline for clickable look
                            color: Color(
                                0xFF1B1919), // Optional: change color on tap
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                fadeTransitionBuilder(
                                  const TermsAndConditionsPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CustomTextButton(
                  text: 'Sign In',
                  onPressed: () {
                    if (_isChecked == true) {
                      emailPasswordAuth().whenComplete(saveData);
                    } else {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Terms and Conditions',
                          text:
                              'You need to read, understand and accept terms and conditions to proceed');
                    }
                  }),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Already have an account?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            FontWeight.normal, // Underline for clickable look
                        color:
                            Color(0xFF1B1919), // Optional: change color on tap
                      ),
                    ),
                    TextSpan(
                      text: " Log In",
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
                              const LoginPage(),
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
