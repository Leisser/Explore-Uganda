import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_uganda/home/First/details/attraction_details.dart';

import '../../../constants/constants.dart';
import 'package:flutter/material.dart';

class Attractions extends StatefulWidget {
  const Attractions({super.key});

  @override
  State<Attractions> createState() => _AttractionsState();
}

class _AttractionsState extends State<Attractions> {
  Stream<QuerySnapshot>? attractionsStream;
  var attractionDocs;
  int _current = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    attractionsStream = FirebaseFirestore.instance
        .collection('attraction')
        .limit(1)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: attractionsStream,
        builder: (context, snapshot) {
          // print('object');
          // print(snapshot.hasData);
          // print('object');
          // final attractionData =
          //     snapshot.data!.docs.first.data();
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              return snapshot.hasData
                  ? SizedBox(
                      height: 400,
                      width: double.infinity,
                      child: ListView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final docData = snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;
                          print(docData['images'][0]);
                          final CarouselController _controller =
                              CarouselController();

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AttractionDetailPage(
                                              allData:
                                                  snapshot.data!.docs[index])));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: CarouselSlider(
                                          carouselController: _controller,
                                          items: docData['images']
                                              .map<Widget>((url) {
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
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        left: 0,
                                        right: 0,
                                        child: SizedBox(
                                          height: 24,
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: docData['images']
                                                .asMap()
                                                .entries
                                                .map<Widget>((entry) {
                                              return GestureDetector(
                                                onTap: () => _controller
                                                    .animateToPage(entry.key),
                                                child: Container(
                                                  width: 12.0,
                                                  height: 12.0,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 4.0),
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
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  docData['category'],
                                  style: categories,
                                ),
                                // SizedBox(height: 5,),
                                Text(
                                  docData['name'],
                                  style: subwords,
                                ),
                                Text(
                                  docData['about'],
                                  style: normalText,
                                  maxLines: 2,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.sizeOf(context).width - 85,
                                      child: Text(
                                        docData['address'],
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        style: normalText,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(child: Text('No attraction found'));
          }
        });
    // ListView.builder(
    //     itemCount: 10,
    //     itemBuilder: (context, int index) {
    //       return Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           // Row(
    //           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           //   children: [
    //           //     Text(
    //           //       'Attraction Sites',
    //           //       style: subwords,
    //           //     ),
    //           //     TextButton(
    //           //         onPressed: () {},
    //           //         child: Text(
    //           //           'View all',
    //           //           style: TextStyle(fontSize: 12),
    //           //         )),
    //           //   ],
    //           // ),
    //           const SizedBox(
    //             height: 5,
    //           ),

    //           Image.asset('assets/attraction.png'),
    //           const SizedBox(
    //             height: 10,
    //           ),
    //           const Text(
    //             'WATER BODIES',
    //             style: categories,
    //           ),
    //           // SizedBox(height: 5,),
    //           const Text(
    //             'Murchison Falls',
    //             style: subwords,
    //           ),
    //           const Text(
    //             'Experience Uganda’s largest waterfall and enjoy nature',
    //             style: normalText,
    //           ),
    //           const SizedBox(
    //             height: 5,
    //           ),
    //           const Row(
    //             children: [
    //               Icon(
    //                 Icons.location_on_outlined,
    //                 size: 15,
    //               ),
    //               Text(
    //                 'Masindi, Uganda',
    //                 style: normalText,
    //               )
    //             ],
    //           )
    //         ],
    //       );
    //     });
  }
}
