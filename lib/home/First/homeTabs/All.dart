import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_uganda/value_notifier/value_notifier.dart';

import '../../../constants/constants.dart';
import 'package:flutter/material.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  Stream<QuerySnapshot>? attractionsStream;
  var attractionDocs;
  var accomodationDocs;
  var investmentDocs;
  Future<List<QueryDocumentSnapshot>> getAttraction() async {
    final collectionRef = FirebaseFirestore.instance.collection('attraction');
    final querySnapshot = await collectionRef.get();

    setState(() {
      attractionDocs = querySnapshot.docs;
    });
    return attractionDocs;
  }

  Future<List<QueryDocumentSnapshot>> getAccomodation() async {
    final collectionRef = FirebaseFirestore.instance.collection('accomodation');
    final querySnapshot = await collectionRef.get();

    setState(() {
      accomodationDocs = querySnapshot.docs;
    });
    return accomodationDocs;
  }

  final CarouselController _controller = CarouselController();
  int _current = 0;

  Future<List<QueryDocumentSnapshot>> getInvestment() async {
    final collectionRef = FirebaseFirestore.instance.collection('investment');
    final querySnapshot = await collectionRef.get();

    setState(() {
      investmentDocs = querySnapshot.docs;
    });
    return investmentDocs;
  }

  @override
  void initState() {
    super.initState();
    attractionsStream = FirebaseFirestore.instance
        .collection('attraction')
        .limit(1)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
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
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final docData = snapshot.data!.docs[index]
                                      .data() as Map<String, dynamic>;
                                  print(docData['images'][0]);

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Attraction Sites',
                                            style: subwords,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                setState(() {
                                                  tabPageIndex.value = 1;
                                                });
                                              },
                                              child: const Text(
                                                'View all',
                                                style: TextStyle(fontSize: 12),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
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
                                                          BorderRadius.circular(
                                                              10),
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
                                                  onPageChanged:
                                                      (index, reason) {
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
                                                          .animateToPage(
                                                              entry.key),
                                                      child: Container(
                                                        width: 12.0,
                                                        height: 12.0,
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 8.0,
                                                            horizontal: 4.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: _current ==
                                                                  entry.key
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            size: 15,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width -
                                                85,
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
                                  );
                                },
                              ),
                            )
                          : const Center(child: Text('No attraction found'));
                  }
                }),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Accomodation',
                      style: subwords,
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            tabPageIndex.value = 2;
                          });
                        },
                        child: const Text(
                          'View all',
                          style: TextStyle(fontSize: 12),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),

                Image.asset('assets/accomodation.png'),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'VILLA',
                  style: categories,
                ),
                // SizedBox(height: 5,),
                const Text(
                  'Flat in Kampala',
                  style: subwords,
                ),
                const Text(
                  '1 bedroom with a spacious living room',
                  style: normalText,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    RichText(
                      text: const TextSpan(
                          text: "\$23",
                          style: subwords,
                          children: [
                            TextSpan(
                              text: "/night",
                            ),
                          ]),
                    )
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Investment Options',
                      style: subwords,
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            tabPageIndex.value = 3;
                          });
                        },
                        child: const Text(
                          'View all',
                          style: TextStyle(fontSize: 12),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),

                Image.asset('assets/investment.png'),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'INVESTMENTS',
                  style: categories,
                ),
                // SizedBox(height: 5,),
                const Text(
                  'Several Investment Options in Uganda',
                  style: subwords,
                ),
                const Text(
                  'Diversify your portfolio by investing in different industries',
                  style: normalText,
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
