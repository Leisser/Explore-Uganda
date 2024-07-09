import 'package:country_flags/country_flags.dart';
import 'package:explore_uganda/value_notifier/value_notifier.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import '../../../constants/constants.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  List languages = ['French', 'German', 'Swahili', 'Spanish', 'English'];
  List countryCodes = ['FR', 'GE', 'KE', 'ES', 'GB'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                    'Language',
                    style: subheadings,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 500,
            width: 600,
            child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    onTap: () {
                      language.value != languages[i]
                          ? QuickAlert.show(
                              context: context,
                              type: QuickAlertType.info,
                              text: 'Coming soon',
                              autoCloseDuration: const Duration(seconds: 2),
                            )
                          : QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'Set',
                              autoCloseDuration: const Duration(seconds: 2),
                            );
                    },
                    leading: CountryFlag.fromCountryCode(
                      countryCodes[i],
                      height: 30,
                      width: 60,
                      shape: const RoundedRectangle(6),
                    ),
                    title: Text(
                      languages[i],
                      style: languagestext,
                    ),
                    trailing: language.value == languages[i]
                        ? const Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: appcolor,
                              child: Center(
                                  child: Icon(
                                Icons.check,
                                size: 19,
                                fill: 1,
                              )),
                            ),
                          )
                        : const SizedBox(),
                  );
                }),
          )
        ],
      ),
    );
  }
}
