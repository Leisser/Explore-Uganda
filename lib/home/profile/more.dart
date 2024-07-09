import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_uganda/default_export.dart';
import 'package:explore_uganda/home/profile/morePages/add_attraction.dart';
import 'package:explore_uganda/onboarding/sign_out.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quickalert/quickalert.dart';

import '../../constants/constants.dart';
import '../../customComponents/CustomAppRow.dart';
import '../../customComponents/customButton.dart';
import '../../customComponents/customProfileAvatar.dart';
import '../../onboarding/sign_up_page.dart';
import 'morePages/editProfile.dart';
import 'morePages/language.dart';
import 'morePages/notification.dart';
import 'morePages/privacyPolicy.dart';
import 'morePages/support.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  String url = '';
  String? name;
  String? email;
  String? phoneNumber;
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    getUserData();
    getAdmin();
  }

  getAdmin() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (snapshot.exists) {
      setState(() {
        isAdmin = snapshot.data()!['isAdmin'];
      });
    }
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      url = prefs.getString('image')!;
      name = prefs.getString('username');
      email = prefs.getString('email');
      phoneNumber = prefs.getString('phoneNumber');
    });
  }

  void _showRateUsModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: bpadding,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 6,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset('assets/logo.png'),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Rate your experience while using the app',
                    style: subheadings,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: appcolor,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  reusableButton(text: 'Submit', onPressed: () {})
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: bpadding,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [Image.asset('assets/logo.png')],
                      ),
                      const CustomAppRow()
                    ]),
                const SizedBox(
                  height: 30,
                ),
                ProfileAvatar(
                  url: url,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(name ?? ''),
                Text(email ?? ''),
                Text(phoneNumber ?? '+256 708 567 892'),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0XFFE1E1E1), width: 0.7),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        InkWell(
                          child: const Row(
                            children: [
                              Icon(
                                Icons.account_circle_outlined,
                                color: appcolor,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Edit Profile')
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EditProfile()),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Language()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.translate_outlined,
                                    color: appcolor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text('Language')
                                ],
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    language.value,
                                    style: const TextStyle(color: appcolor),
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Notifications()),
                            );
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.notifications_active_outlined,
                                color: appcolor,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Notification')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0XFFE1E1E1), width: 0.7),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.info,
                              text: 'Coming soon',
                              autoCloseDuration: const Duration(seconds: 2),
                            );
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.fire_truck_outlined,
                                color: appcolor,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Deals')
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.info,
                              text: 'Coming soon',
                              autoCloseDuration: const Duration(seconds: 2),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.favorite_border_outlined,
                                    color: appcolor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text('Wishlist')
                                ],
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               const CurrencyConverter()),
                        //     );
                        //   },
                        //   child: const Row(
                        //     children: [
                        //       Icon(
                        //         Icons.sync_alt_outlined,
                        //         color: appcolor,
                        //       ),
                        //       SizedBox(
                        //         width: 15,
                        //       ),
                        //       Text('Currency Converter')
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                isAdmin
                    ? const SizedBox(
                        height: 20,
                      )
                    : const SizedBox(),
                isAdmin
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0XFFE1E1E1), width: 0.7),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddAttractionPage()),
                                  );
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.tour,
                                      color: appcolor,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text('Add attractions')
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.info,
                                    text: 'Coming soon',
                                    autoCloseDuration:
                                        const Duration(seconds: 2),
                                  );
                                },
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.house,
                                          color: appcolor,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text('Add accomodation')
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.info,
                                    text: 'Coming soon',
                                    autoCloseDuration:
                                        const Duration(seconds: 2),
                                  );
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.event,
                                      color: appcolor,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text('Add event')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0XFFE1E1E1), width: 0.7),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: _showRateUsModal,
                          child: const Row(
                            children: [
                              Icon(
                                Icons.star_rate_outlined,
                                color: appcolor,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Rating')
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Support()),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.help_outline_outlined,
                                    color: appcolor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text('Support')
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PrivacyPolicy()),
                            );
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.lock_outlined,
                                color: appcolor,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Privacy policy')
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.logout_outlined,
                              color: appcolor,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                                onTap: () {
                                  QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.confirm,
                                      title: 'Sign Out',
                                      onCancelBtnTap: () {
                                        Navigator.pop(context);
                                      },
                                      onConfirmBtnTap: () {
                                        signOutFromGoogle().whenComplete(() {
                                          Navigator.push(
                                            context,
                                            fadeTransitionBuilder(
                                              const SignUpPage(),
                                            ),
                                          );
                                        });
                                      },
                                      text: 'Confirm sign out');
                                },
                                child: const Text('Logout'))
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
