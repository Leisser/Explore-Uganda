import 'dart:math';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_uganda/default_export.dart';
import 'package:explore_uganda/home/profile/morePages/editProfile.dart';
import 'package:explore_uganda/services/multiple_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

import '../../../constants/constants.dart';
import '../../../models/auth/chatMessageModel.dart';
import '../../../services/picture-gallary.dart';
import '../../../services/picture_camera.dart';
import 'chat_list.dart';

class LiveChat extends StatefulWidget {
  const LiveChat({super.key});

  @override
  State<LiveChat> createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  String? chatId;
  String? url;
  String? name;
  String? email;
  String? phoneNumber;
  bool isAdmin = false;
  bool loading1Pic = false;
  bool loadingSeveralPics = false;
  bool isUploading = false;
  var imagelink;
  var imageGroup;
  final CarouselController _controller = CarouselController();
  int _current = 0;
  List meassageList = [];
  final ScrollController _scrollController = ScrollController();
  TextEditingController _controllerText = TextEditingController();

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
    knowUserStatus();
    getUserData();
    getChatHandle();
    getAdmin();
  }

  knowUserStatus() async {
    final snapShot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      isAdmin = snapShot.data()!['isAdmin'];
    });
  }

  Future<void> setPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      url = prefs.getString('image')!;
      name = prefs.getString('username');
      email = prefs.getString('email');
      phoneNumber = prefs.getString('phoneNumber')!;
    });
  }

  getUserData() async {
    setPrefs().whenComplete(() {
      if (phoneNumber!.isEmpty ||
          email!.isEmpty ||
          phoneNumber == '' ||
          email == '') {
        Navigator.push(
          context,
          slideTransitionBuilder(
            const EditProfile(
              showReason: true,
            ),
          ),
        );
      }
    });
  }

  getAdmin() {
    setPrefs().whenComplete(() async {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (snapshot.exists) {
        setState(() {
          isAdmin = snapshot.data()!['isAdmin'];
        });
      }
    });
  }

  getChatHandle() {
    setPrefs().whenComplete(() async {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String chatextention = getRandomString(5);
      final snapshot = await FirebaseFirestore.instance
          .collection('chatList')
          .where('user', isEqualTo: userId)
          .get();
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          chatId = snapshot.docs.first.data()['chatId'];
        });
        getOnlineDocs(snapshot.docs.first.id);
      } else {
        final query =
            FirebaseFirestore.instance.collection('chatList').doc(userId);
        await query.set({
          'chatId': "$userId$chatextention",
          'user': userId,
          'date': DateTime.now().toIso8601String(),
          'image': url,
          'name': name,
          'email': email,
          'phoneNumber': phoneNumber,
        });
      }
    });
  }

  Future<void> addMessage() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final query = FirebaseFirestore.instance.collection(chatId!);
    await query.add({
      'text': _controllerText.text,
      'isSender': userId,
      'isSeen': false,
      'imagesList': imageGroup != null
          ? imageGroup
          : imagelink != null
              ? [imagelink]
              : [],
      'timestamp': Timestamp.now(),
      'delivered': true,
      'uploaded': true,
    });
  }

  Future<void> addMessageToList() async {
    setState(() {
      meassageList.add(ChatMessage(
        message_number: '',
        isSender: true,
        isSeen: false,
        timestamp: Timestamp.now(),
        delivered: true,
        uploaded: true,
        text: _controllerText.text,
        imagesList: imageGroup != null
            ? imageGroup
            : imagelink != null
                ? [imagelink]
                : [],
      ));
    });
  }

  getOnlineDocs(String idchat) {
    setPrefs().whenComplete(() async {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String chatextention = getRandomString(5);
      final snapshot = await FirebaseFirestore.instance
          .collection(idchat)
          .orderBy('timestamp', descending: false)
          .get();
      if (snapshot.docs.isNotEmpty) {
        for (var i = 0; i < snapshot.docs.length; i++) {
          setState(() {
            meassageList.add(ChatMessage(
              message_number: '',
              isSender: snapshot.docs[i].data()['isSender'] == userId,
              isSeen: snapshot.docs[i].data()['isSeen'],
              timestamp: snapshot.docs[i].data()['timestamp'],
              delivered: snapshot.docs[i].data()['delivered'],
              uploaded: snapshot.docs[i].data()['uploaded'],
              text: snapshot.docs[i].data()['text'],
              imagesList: List.from(snapshot.docs[i].data()['imagesList']),
            ));
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/chat/chatbackground.png'),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                              icon:
                                  const Icon(Icons.arrow_back_ios_new_outlined))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 50, bottom: 10, left: 20),
                            child: Text(
                              'Live Chat',
                              style: subheadings,
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                            height: 2,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChatListPage()));
                            },
                            child: const Icon(
                              Icons.admin_panel_settings,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: loading1Pic ||
                          loadingSeveralPics ||
                          imageGroup != null ||
                          imagelink != null
                      ? MediaQuery.sizeOf(context).height - 400
                      : MediaQuery.sizeOf(context).height - 300,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    itemCount: meassageList.length,
                    itemBuilder: (context, i) {
                      return _buildMessage(meassageList[i]);
                    },
                  ),
                )
              ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  loading1Pic
                      ? const NutsActivityIndicator(
                          activeColor: Colors.indigo,
                          inactiveColor: Colors.blueGrey,
                          tickCount: 24,
                          relativeWidth: 0.4,
                          radius: 30,
                          startRatio: 0.7,
                          animationDuration: Duration(milliseconds: 500),
                        )
                      : imagelink.toString().isNotEmpty && imagelink != null
                          ? Container(
                              height: 100,
                              width: 100,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                border: Border.all(width: 2, color: appcolor),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      imagelink.toString()),
                                ),
                              ),
                            )
                          : const SizedBox(),
                  loadingSeveralPics
                      ? const NutsActivityIndicator(
                          activeColor: Colors.indigo,
                          inactiveColor: Colors.blueGrey,
                          tickCount: 24,
                          relativeWidth: 0.4,
                          radius: 30,
                          startRatio: 0.7,
                          animationDuration: Duration(milliseconds: 500),
                        )
                      : imageGroup.toString().isNotEmpty && imageGroup != null
                          ? Container(
                              height: 100,
                              width: 100,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                border: Border.all(width: 2, color: appcolor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  CarouselSlider(
                                    carouselController: _controller,
                                    items: imageGroup.map<Widget>((url) {
                                      return Container(
                                        height: 100,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                CachedNetworkImageProvider(url),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    options: CarouselOptions(
                                      height: 100,
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
                                        children: imageGroup
                                            .asMap()
                                            .entries
                                            .map<Widget>((entry) {
                                          return GestureDetector(
                                            onTap: () => _controller
                                                .animateToPage(entry.key),
                                            child: Container(
                                              width: 5.0,
                                              height: 5.0,
                                              margin:
                                                  const EdgeInsets.symmetric(
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
                          : const SizedBox(),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                showAdaptiveActionSheet(
                                  bottomSheetColor: const Color(0xFFF3BC43),
                                  context: context,
                                  actions: <BottomSheetAction>[
                                    BottomSheetAction(
                                      title: const Text('Camera'),
                                      onPressed: (_) async {
                                        Navigator.pop(context);
                                        setState(() {
                                          loading1Pic = true;
                                          imageGroup = null;
                                          imagelink = null;
                                        });
                                        final imageUploadService =
                                            ImageUploadServiceCamera(
                                                bcketName: 'chats');
                                        imagelink = await imageUploadService
                                            .pickImage();

                                        setState(() {
                                          loading1Pic = false;
                                        });
                                      },
                                    ),
                                    BottomSheetAction(
                                      title: const Text('Gallary'),
                                      onPressed: (_) async {
                                        Navigator.pop(context);
                                        setState(() {
                                          loading1Pic = true;
                                          imageGroup = null;
                                          imagelink = null;
                                        });

                                        final imageUploadService =
                                            ImageUploadServiceGallery(
                                                bcketName: 'chats');
                                        imagelink = await imageUploadService
                                            .pickImage();

                                        setState(() {
                                          loading1Pic = false;
                                        });
                                      },
                                    ),
                                    BottomSheetAction(
                                      title: const Text('Multiple Images'),
                                      onPressed: (_) async {
                                        Navigator.pop(context);
                                        setState(() {
                                          loadingSeveralPics = true;
                                          imageGroup = null;
                                          imagelink = null;
                                        });

                                        final imageUploadService =
                                            ImageUploadServiceMultipleGallarey(
                                                bcketName: 'chats');
                                        imageGroup = await imageUploadService
                                            .pickImage();

                                        setState(() {
                                          loadingSeveralPics = false;
                                        });
                                      },
                                    ),
                                  ],
                                  cancelAction:
                                      CancelAction(title: const Text('Cancel')),
                                );
                              },
                              icon: const Icon(Icons.camera_alt_outlined)),
                          Expanded(
                            child: TextFormField(
                              controller: _controllerText,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0XFFF5F5F5),
                                hintText: 'Type to reply',
                                hintStyle: hintext,
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.emoji_emotions_outlined)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0.2, horizontal: 20.0),
                              ),
                            ),
                          ),
                          imagelink != null ||
                                  imageGroup != null ||
                                  _controllerText.text.isNotEmpty
                              ? InkWell(
                                  onTap: () {
                                    addMessage().whenComplete(() {
                                      addMessageToList().whenComplete(() {
                                        setState(() {
                                          imageGroup = null;
                                          imagelink = null;
                                          _controllerText.text = '';
                                        });
                                      });
                                    });
                                  },
                                  child: Icon(
                                    Icons.send,
                                    color: appcolor,
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    final CarouselController __controller = CarouselController();
    return Align(
      alignment:
          message.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.65,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
            bottomLeft:
                message.isSender ? const Radius.circular(10.0) : Radius.zero,
            bottomRight:
                message.isSender ? Radius.zero : const Radius.circular(10.0),
          ),
          color: message.isSender ? Colors.blue[100] : Colors.grey[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            message.imagesList!.isNotEmpty
                ? Stack(
                    children: [
                      CarouselSlider(
                        carouselController: __controller,
                        items: message.imagesList!.map<Widget>((url) {
                          return Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(url),
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
                              // _current = index;
                            });
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 24,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: appcolor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: message.imagesList!
                                .asMap()
                                .entries
                                .map<Widget>((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    __controller.animateToPage(entry.key),
                                child: Container(
                                  width: 10.0,
                                  height: 5.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 1.0),
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
                  )
                : const SizedBox(),
            SizedBox(
              height: 5,
            ),
            Text(message.text ?? ''),
          ],
        ),
      ),
    );
  }
}
