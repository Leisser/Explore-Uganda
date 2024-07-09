import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../constants/constants.dart';
import '../../../customComponents/customButton.dart';

class AttractionDetailPage extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> allData;
  const AttractionDetailPage({super.key, required this.allData});

  @override
  State<AttractionDetailPage> createState() => _AttractionDetailPageState();
}

class _AttractionDetailPageState extends State<AttractionDetailPage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(children: [
                    Positioned.fill(
                      child: CarouselSlider(
                        carouselController: _controller,
                        items: widget.allData['images'].map<Widget>((url) {
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
                              _current = index;
                            });
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: 24,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.allData['images']
                              .asMap()
                              .entries
                              .map<Widget>((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 12.0,
                                height: 12.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == entry.key
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: unselectedTileColor,
                                ),
                                child: Center(
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios_new_outlined,
                                        color: Colors.black,
                                        size: 16,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: unselectedTileColor,
                                ),
                                child: Center(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.favorite_outlined,
                                        color: Colors.white,
                                        size: 16,
                                      )),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
                ),
                Padding(
                  padding: bpadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.allData['name'],
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 15,
                            color: appcolor,
                          ),
                          Text(
                            '4.1',
                            style: normalText,
                          ),
                          Text(
                            "(${widget.allData['reviews']} reviews)",
                            style: normalText,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 15,
                          ),
                          Text(
                            widget.allData['location'] ??
                                'Will be added with field visit',
                            style: normalText,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            size: 15,
                          ),
                          Text(
                            '${List.from(widget.allData['opendays']).first} - ${List.from(widget.allData['opendays']).last}: ${widget.allData['openhour']}',
                            style: normalText,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'About',
                        style: subtitle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ReadMoreText(
                        widget.allData['about'],
                        trimMode: TrimMode.Line,
                        trimLines: 2,
                        colorClickableText: Colors.pink,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Textfieldcolor,
                        ),
                        child: Center(
                          child: Text(
                            'Coming soon',
                            style: subtitle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: appcolor,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                              width: MediaQuery.sizeOf(context).width * .7,
                              child: Text(widget.allData['address']))
                        ],
                      ),
                      SizedBox(
                        height: 65,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: reusableButton(
                text: 'Contact',
                icon: Icons.phone,
                onPressed: () {
                  _showSheetWithBorderRadius(
                      widget.allData['website'], widget.allData['phonenumber']);
                }),
          ),
        ]),
      ),
    );
  }

  void _showSheetWithBorderRadius(website, phonenumber) {
    showFlexibleBottomSheet<void>(
      minHeight: 0,
      initHeight: 0.3,
      maxHeight: 0.8,
      context: context,
      bottomSheetBorderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      bottomSheetColor: Colors.white,
      builder: (context, controller, offset) {
        return _BottomSheet(
          scrollController: controller,
          bottomSheetOffset: offset,
          website: website,
          phoneNumber: phonenumber,
        );
      },
    );
  }
}

class _BottomSheet extends StatelessWidget {
  final ScrollController scrollController;
  final double bottomSheetOffset;
  final String website;
  final String phoneNumber;

  const _BottomSheet({
    required this.scrollController,
    required this.bottomSheetOffset,
    required this.website,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      controller: scrollController,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contact Information',
                    style: subheadings,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 25,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Website',
                style: subtitle,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                website,
                style: normalText,
              ),
              Divider(
                height: 1,
                color: appcolor,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'PhoneNumber',
                style: subtitle,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                phoneNumber,
                style: normalText,
              ),
              Divider(
                height: 1,
                color: appcolor,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
