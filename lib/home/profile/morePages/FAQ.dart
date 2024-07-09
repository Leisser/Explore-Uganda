import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
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
                        'FAQs',
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
                  children: [
                    // Search Text Field
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Enter your keyword',
                          hintStyle: normalText,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0XFFDFF1FF)),
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.notifications_on_outlined,
                                    color: Color(0XFF1573FE),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Questions about',
                                    style: normalText,
                                  ),
                                  Text(
                                    'Getting Started',
                                    style: subwords,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0XFFE8FFEB)),
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.settings_outlined,
                                    color: Color(0XFF049C6B),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Questions about',
                                    style: normalText,
                                  ),
                                  Text(
                                    'How to Invest',
                                    style: subwords,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0XFFFFECEF)),
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.local_atm_outlined,
                                    color: Color(0XFFDF1525),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Questions about',
                                    style: normalText,
                                  ),
                                  Text(
                                    'Payment Method',
                                    style: subwords,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      'Top Questions',
                      style: subtitle,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color(0XFFE1E1E1), width: 1)),
                          child: const ExpansionTile(
                            title: Text('How to book a fleet service?',
                                style: TextColor),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Open the marketplace page of the app, and scroll to the fleet services section. Choose your preferred provider and click the book button to be redirected to their page.',
                                  style: normalText,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color(0XFFE1E1E1), width: 1)),
                          child: const ExpansionTile(
                            title: Text(
                                'What are the top features this Explore Uganda has to offer?',
                                style: TextColor),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Open the marketplace page of the app, and scroll to the fleet services section. Choose your preferred provider and click the book button to be redirected to their page.',
                                  style: normalText,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
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
