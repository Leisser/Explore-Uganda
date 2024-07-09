import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_uganda/default_export.dart';
import 'package:explore_uganda/services/picture-gallary.dart';
import 'package:explore_uganda/services/picture_camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:quickalert/quickalert.dart';

class ProfileAvatar extends StatefulWidget {
  String url;

  ProfileAvatar({super.key, this.url = ''});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  bool loading = false;
  Future<void> saveData(image) async {
    Navigator.of(context, rootNavigator: true).pop('dialog');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('image', image);
    DocumentReference reference = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await reference.update({
      "image": image,
    });
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      child: Stack(children: [
        ClipOval(
          clipBehavior: Clip.hardEdge,
          child: loading
              ? const NutsActivityIndicator(
                  activeColor: Colors.indigo,
                  inactiveColor: Colors.blueGrey,
                  tickCount: 24,
                  relativeWidth: 0.4,
                  radius: 30,
                  startRatio: 0.7,
                  animationDuration: Duration(milliseconds: 500),
                )
              : widget.url.isNotEmpty
                  ? CachedNetworkImage(imageUrl: widget.url)
                  : Image.asset(
                      'assets/profile.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: Center(
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0XFFF5F5F5),
                ),
                child: IconButton(
                    onPressed: () {
                      showAdaptiveActionSheet(
                        bottomSheetColor: const Color(0xFFF3BC43),
                        context: context,
                        actions: <BottomSheetAction>[
                          BottomSheetAction(
                            title: const Text('Camera'),
                            onPressed: (_) {
                              Navigator.pop(context);
                              setState(() {
                                loading = true;
                              });
                              final imageUploadService =
                                  ImageUploadServiceCamera();
                              var imagelink = imageUploadService.pickImage();

                              imagelink.then((value) {
                                setState(() {
                                  loading = false;
                                });
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.confirm,
                                  text: 'Confirm profile picture change',
                                  confirmBtnText: 'Yes',
                                  cancelBtnText: 'No',
                                  onConfirmBtnTap: () {
                                    saveData(value).whenComplete(() {
                                      setState(() {
                                        widget.url = value!;
                                      });

                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.success,
                                        text: 'Profile picture changed',
                                      );
                                    });
                                  },
                                  confirmBtnColor: Colors.green,
                                );
                              });
                            },
                          ),
                          BottomSheetAction(
                            title: const Text('Gallary'),
                            onPressed: (_) {
                              Navigator.pop(context);
                              setState(() {
                                loading = true;
                              });

                              final imageUploadService =
                                  ImageUploadServiceGallery();
                              var imagelink = imageUploadService.pickImage();

                              imagelink.then((value) {
                                setState(() {
                                  loading = false;
                                });
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.confirm,
                                  text: 'Confirm profile picture change',
                                  confirmBtnText: 'Yes',
                                  cancelBtnText: 'No',
                                  onConfirmBtnTap: () {
                                    saveData(value).whenComplete(() {
                                      setState(() {
                                        widget.url = value!;
                                      });
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.success,
                                        text: 'Profile picture changed',
                                      );
                                    });
                                  },
                                  confirmBtnColor: Colors.green,
                                );
                              });
                            },
                          ),
                        ],
                        cancelAction: CancelAction(title: const Text('Cancel')),
                      );
                    },
                    icon: const Icon(
                      Icons.edit_outlined,
                      size: 14,
                    )),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
