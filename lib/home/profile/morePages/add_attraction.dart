import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:quickalert/quickalert.dart';

import '../../../constants/constants.dart';
import '../../../services/multiple_images.dart';

class AddAttractionPage extends StatefulWidget {
  const AddAttractionPage({super.key});

  @override
  State<AddAttractionPage> createState() => _AddAttractionPageState();
}

class _AddAttractionPageState extends State<AddAttractionPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController longtitudeController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  List category = [
    'Museums',
    'Galleries',
    'National Parks',
    'National Reserves',
    'Water bodies',
    'Gardens',
  ];
  int? pickedIndex;
  String? pickedOpeningTime;
  String? pickedClosingTime;
  List imageList = [];
  CarouselController _controller = CarouselController();
  int _current = 0;
  bool loading = false;
  bool upLoading = false;

  Future<TimeOfDay?> pickOpenTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 7, minute: 15); // Default initial time

    try {
      final newTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );
      if (newTime != null) {
        setState(() {
          pickedOpeningTime = newTime.toString().substring(10, 15);
        });
        return newTime; // Return selected time if available
      } else {
        return null; // Handle user cancellation (pressing back button)
      }
    } catch (error) {
      // Handle potential errors during time picker display
      print('Error displaying time picker: $error');
      return null; // Or provide a default or error time as needed
    }
  }

  Future<TimeOfDay?> pickCloseTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 7, minute: 15); // Default initial time

    try {
      final newTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );
      if (newTime != null) {
        setState(() {
          pickedClosingTime = newTime.toString().substring(10, 15);
        });
        return newTime; // Return selected time if available
      } else {
        return null; // Handle user cancellation (pressing back button)
      }
    } catch (error) {
      // Handle potential errors during time picker display
      print('Error displaying time picker: $error');
      return null; // Or provide a default or error time as needed
    }
  }

  uploadAttraction() async {
    if (descriptionController.text.isNotEmpty &&
        pickedIndex != null &&
        websiteController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        pickedOpeningTime!.isNotEmpty &&
        pickedClosingTime!.isNotEmpty &&
        nameController.text.isNotEmpty &&
        imageList.isNotEmpty) {
      setState(() {
        upLoading = true;
      });
      final query = FirebaseFirestore.instance.collection('chatList');
      await query.add({
        'about': descriptionController.text,
        'category': category[pickedIndex!],
        'date': DateTime.now().toIso8601String(),
        'image': imageList,
        'address': '',
        'latitude': latitudeController.text,
        'longtitude': longtitudeController.text,
        'location': '',
        'name': nameController.text,
        'opendays': [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday'
        ],
        'reviews': 0,
        'openhour': '$pickedOpeningTime - $pickedClosingTime',
        'email': emailController.text,
        'phonenumber': phoneNumberController.text,
        'website': websiteController.text,
      });
      setState(() {
        upLoading = false;
      });
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        text: 'Upload success',
        autoCloseDuration: const Duration(seconds: 2),
      );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        text: 'Fill all Fields',
        autoCloseDuration: const Duration(seconds: 2),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

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
                        'Add Attraction sites',
                        style: subheadings,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: MediaQuery.sizeOf(context).height - 200,
                  padding: bpadding,
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Images',
                            style: subtitle,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          imageList.length > 0
                              ? SizedBox(
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      CarouselSlider(
                                        carouselController: _controller,
                                        items: imageList.map<Widget>((url) {
                                          return Container(
                                            height: 200,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    CachedNetworkImageProvider(
                                                        url),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        options: CarouselOptions(
                                          height: 200,
                                          viewportFraction: 1,
                                          enlargeCenterPage: true,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              _current = index;
                                            });
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: 24,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: appcolor),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: imageList
                                                .asMap()
                                                .entries
                                                .map<Widget>((entry) {
                                              return GestureDetector(
                                                onTap: () => _controller
                                                    .animateToPage(entry.key),
                                                child: Container(
                                                  width: 5.0,
                                                  height: 5.0,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 1.0),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: _current == entry.key
                                                        ? Colors.greenAccent
                                                        : Colors.black,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : loading
                                  ? const NutsActivityIndicator(
                                      activeColor: Colors.indigo,
                                      inactiveColor: Colors.blueGrey,
                                      tickCount: 24,
                                      relativeWidth: 0.4,
                                      radius: 30,
                                      startRatio: 0.7,
                                      animationDuration:
                                          Duration(milliseconds: 500),
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        setState(() {
                                          loading = true;
                                        });
                                        final imageUploadService =
                                            ImageUploadServiceMultipleGallarey(
                                                bcketName: 'attractions');
                                        imageList = await imageUploadService
                                            .pickImage();
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: appcolor,
                                            border: Border.all(
                                                color: const Color(0XFFE1E1E1),
                                                width: 0.7),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Center(
                                          child: Text(
                                            'Add Images',
                                            style: subtitle,
                                          ),
                                        ),
                                      ),
                                    ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Overview',
                            style: subtitle,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0XFFE1E1E1), width: 0.7),
                                borderRadius: BorderRadius.circular(8)),
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: 'Name',
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
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0XFFE1E1E1), width: 0.7),
                                borderRadius: BorderRadius.circular(8)),
                            child: TextFormField(
                              maxLines: 6,
                              controller: descriptionController,
                              decoration: InputDecoration(
                                hintText: 'Description',
                                hintStyle: hintext,
                                filled: true,

                                fillColor:
                                    Textfieldcolor, // Set the background color to yellow
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none, // No border
                                ),
                              ),
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Location Information',
                            style: subtitle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: category.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        pickedIndex = index;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: pickedIndex == index
                                              ? appcolor
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child:
                                          Center(child: Text(category[index])),
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width * .4,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0XFFE1E1E1),
                                        width: 0.7),
                                    borderRadius: BorderRadius.circular(8)),
                                child: TextField(
                                  controller: longtitudeController,
                                  decoration: InputDecoration(
                                    hintText: 'Longtitude',
                                    hintStyle: hintext,
                                    filled: true,
                                    fillColor:
                                        Textfieldcolor, // Set the background color to yellow
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none, // No border
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * .4,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0XFFE1E1E1),
                                        width: 0.7),
                                    borderRadius: BorderRadius.circular(8)),
                                child: TextField(
                                  controller: latitudeController,
                                  decoration: InputDecoration(
                                    hintText: 'Latitude',
                                    hintStyle: hintext,
                                    filled: true,
                                    fillColor:
                                        Textfieldcolor, // Set the background color to yellow
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none, // No border
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  await pickOpenTime(context);
                                },
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * .4,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Textfieldcolor,
                                      border: Border.all(
                                          color: const Color(0XFFE1E1E1),
                                          width: 0.7),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Center(
                                        child: pickedOpeningTime != null
                                            ? Text(pickedOpeningTime.toString())
                                            : Text('Opening Time'),
                                      ),
                                      Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap: () async {
                                  await pickCloseTime(context);
                                },
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * .4,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Textfieldcolor,
                                      border: Border.all(
                                          color: const Color(0XFFE1E1E1),
                                          width: 0.7),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Center(
                                        child: pickedClosingTime != null
                                            ? Text(pickedClosingTime.toString())
                                            : Text('Closing Time'),
                                      ),
                                      Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Contact Information',
                            style: subtitle,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0XFFE1E1E1), width: 0.7),
                                borderRadius: BorderRadius.circular(8)),
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
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
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0XFFE1E1E1), width: 0.7),
                                borderRadius: BorderRadius.circular(8)),
                            child: TextField(
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                hintText: 'Phone number',
                                hintStyle: hintext,
                                filled: true,
                                fillColor:
                                    Textfieldcolor, // Set the background color to yellow
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none, // No border
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0XFFE1E1E1), width: 0.7),
                                borderRadius: BorderRadius.circular(8)),
                            child: TextField(
                              controller: websiteController,
                              decoration: InputDecoration(
                                hintText: 'Website link',
                                hintStyle: hintext,
                                filled: true,
                                fillColor:
                                    Textfieldcolor, // Set the background color to yellow
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none, // No border
                                ),
                              ),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          upLoading
                              ? const NutsActivityIndicator(
                                  activeColor: Colors.indigo,
                                  inactiveColor: Colors.blueGrey,
                                  tickCount: 24,
                                  relativeWidth: 0.4,
                                  radius: 30,
                                  startRatio: 0.7,
                                  animationDuration:
                                      Duration(milliseconds: 500),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    uploadAttraction();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: appcolor,
                                        border: Border.all(
                                            color: const Color(0XFFE1E1E1),
                                            width: 0.7),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                      child: Text(
                                        'Save',
                                        style: subheadings,
                                      ),
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 15,
                          ),
                        ]),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
