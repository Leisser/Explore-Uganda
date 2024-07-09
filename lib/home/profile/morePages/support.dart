import '../../../constants/constants.dart';
import 'package:flutter/material.dart';

import 'FAQ.dart';
import 'aboutApp.dart';
import 'liveChat.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: bpadding,
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: appcolor,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios_new_outlined))
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 10, left: 20),
                      child: Text(
                        'Support',
                        style: subheadings,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: bpadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutApp()),
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color(0XFFE1E1E1), width: 1)),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.info_outline,
                                                color: appcolor,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'About the App',
                                                style: subtitle,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Check out all the information you need about the Explore Uganda application and the team behind it',
                                            style: TextColor,
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.arrow_right_alt_outlined,
                                              color: appcolor,
                                            )),
                                      ],
                                    )
                                  ]))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const FAQ()),
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color(0XFFE1E1E1), width: 1)),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.chat,
                                                color: appcolor,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'FAQs',
                                                style: subtitle,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Stay informed with the latest app updates. And check out the most commonly asked questions by users to help enhance your experience',
                                            style: TextColor,
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.arrow_right_alt_outlined,
                                              color: appcolor,
                                            )),
                                      ],
                                    )
                                  ]))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LiveChat()),
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color(0XFFE1E1E1), width: 1)),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.live_help_outlined,
                                                color: appcolor,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Live Chat',
                                                style: subtitle,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Got questions or need assistance? Our support team is here to help you, 24/7.',
                                            style: TextColor,
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LiveChat()),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.arrow_right_alt_outlined,
                                              color: appcolor,
                                            )),
                                      ],
                                    )
                                  ]))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
