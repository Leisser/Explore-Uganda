
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
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
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30))
                ),
              
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
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
                      child: Text('About the App', style: subheadings,),
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: bpadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your privacy is important to us. It is Brainstorming\'s policy to respect your privacy regarding any information we may collect from you across our application, and other sites we own and operate. \n \nWe only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent. We also let you know why we’re collecting it and how it will be used.\n \nWe only retain collected information for as long as necessary to provide you with your requested service. What data we store, we’ll protect within commercially acceptable means to prevent loss and theft, as well as unauthorized access, disclosure, copying, use or modification. \n \nWe don’t share any personally identifying information publicly or with third-parties, except when required to by law.',
                     style: TextColor,),
                    SizedBox(height: 10,),
                    

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