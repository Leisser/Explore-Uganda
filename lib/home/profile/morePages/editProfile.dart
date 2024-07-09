import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_uganda/default_export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:quickalert/quickalert.dart';

import '../../../constants/constants.dart';
import '../../../customComponents/customButton.dart';
import '../../../customComponents/customProfileAvatar.dart';

class EditProfile extends StatefulWidget {
  final bool showReason;

  const EditProfile({super.key, this.showReason = false});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool loadingOnDataSave = false;
  String url = '';
  String? name;
  String? email;
  String? phoneNumber;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String initialCountry = 'UG';
  PhoneNumber number = PhoneNumber(isoCode: 'UG', phoneNumber: '700000000');

  @override
  void initState() {
    super.initState();
    getUserData();
    showTextReason();
  }

  showTextReason() async {
    if (widget.showReason) {
      Timer(const Duration(seconds: 5), () {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.info,
          text: 'You need to provide a phone number and picture initiate chats',
          autoCloseDuration: const Duration(seconds: 2),
        );
      });
    }
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      url = prefs.getString('image')!;
      name = prefs.getString('username');
      email = prefs.getString('email');
      phoneNumber = prefs.getString('phoneNumber')!;
      number =
          PhoneNumber(isoCode: 'UG', phoneNumber: phoneNumber ?? '700000000');
    });
  }

  Future<void> saveTextData(username, phoneNumber) async {
    setState(() {
      loadingOnDataSave = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username!);
    prefs.setString('phoneNumber', phoneNumber);
    setState(() {
      name = username;
      phoneNumber = phoneNumber;
      number =
          PhoneNumber(isoCode: 'UG', phoneNumber: phoneNumber ?? '700000000');
    });

    DocumentReference reference = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await reference.update({
      "username": username,
      "phoneNumber": phoneNumber,
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
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileAvatar(
                url: url,
              ),
              const SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(text: 'Welcome, ', style: subwords, children: [
                  TextSpan(
                    text: name ?? '',
                  ),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    onChanged: (value) {
                      name = _nameController.text;
                    },
                    decoration: InputDecoration(
                      hintText: name ?? 'Username',
                      hintStyle: hintext,
                      filled: true,
                      fillColor:
                          Textfieldcolor, // Set the background color to yellow
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none, // No border
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: email ?? 'Email Address',
                      hintStyle: hintext,
                      filled: true,
                      fillColor:
                          Textfieldcolor, // Set the background color to yellow
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none, // No border
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber value) {
                      setState(() {
                        phoneNumber = value.phoneNumber;
                      });
                    },
                    onInputValidated: (bool value) {},
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      useBottomSheetSafeArea: true,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    initialValue: number,
                    textFieldController: _phoneController,
                    formatInput: true,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputBorder: const OutlineInputBorder(),
                    onSaved: (PhoneNumber number) {},
                  ),
                  // TextFormField(
                  //   controller: _phoneController,
                  //   decoration: InputDecoration(
                  //     hintText: phoneNumber ?? '+256000000000',
                  //     hintStyle: hintext,
                  //     filled: true,
                  //     fillColor:
                  //         Textfieldcolor, // Set the background color to yellow
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //       borderSide: BorderSide.none, // No border
                  //     ),
                  //   ),
                  //   keyboardType: TextInputType.phone,
                  //   textInputAction: TextInputAction.next,
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  loadingOnDataSave
                      ? const NutsActivityIndicator(
                          activeColor: Colors.indigo,
                          inactiveColor: Colors.blueGrey,
                          tickCount: 24,
                          relativeWidth: 0.4,
                          radius: 30,
                          startRatio: 0.7,
                          animationDuration: Duration(milliseconds: 500),
                        )
                      : reusableButton(
                          text: 'Save',
                          onPressed: () {
                            bool isValidPhoneNumber(String? value) => RegExp(
                                    r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
                                .hasMatch(value ?? '');
                            if (isValidPhoneNumber(phoneNumber)) {
                              saveTextData(name, phoneNumber).whenComplete(() {
                                setState(() {
                                  loadingOnDataSave = false;
                                });
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.info,
                                  text: 'Updated',
                                  autoCloseDuration: const Duration(seconds: 2),
                                );
                              });
                            } else {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.info,
                                text: 'Correct your phone number',
                                // autoCloseDuration: const Duration(seconds: 2),
                              );
                            }
                          },
                        ),
                ],
              ))
            ],
          ),
        ),
      )),
    );
  }
}
