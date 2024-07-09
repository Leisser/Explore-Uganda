import 'package:explore_uganda/home/profile/more.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

import 'First/homeTabs/Events.dart';
import 'First/homeTabs/MarketPlace.dart';
import 'First/home_default.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int index = 0;
  List pages = [
    const HomeDefault(),
    const Events(),
    const MarketPlace(),
    const More(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: UpgradeAlert(
        child: Scaffold(
          extendBody: true,
          body: pages[index],
          bottomNavigationBar: Container(
            height: 85,
            width: MediaQuery.sizeOf(context).width,
            color: const Color(0x00ffffff),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    children: [
                      Container(
                        height: 22,
                        width: MediaQuery.sizeOf(context).width,
                        color: const Color(0x00ffffff),
                      ),
                      Container(
                        height: 63,
                        width: MediaQuery.sizeOf(context).width,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            index = 0;
                          });
                        },
                        child: SizedBox(
                          width: 74,
                          height: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.home_outlined,
                                size: 30,
                                color: index == 0
                                    ? const Color(0xffF3BC43)
                                    : Colors.white,
                              ),
                              Text(
                                'Home',
                                style: TextStyle(
                                  color: index == 0
                                      ? const Color(0xffF3BC43)
                                      : Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            index = 1;
                          });
                        },
                        child: SizedBox(
                          width: 74,
                          height: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.calendar_month_outlined,
                                size: 30,
                                color: index == 1
                                    ? const Color(0xffF3BC43)
                                    : Colors.white,
                              ),
                              Text(
                                'To Do',
                                style: TextStyle(
                                  color: index == 1
                                      ? const Color(0xffF3BC43)
                                      : Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // setState(() {
                          //   index = 2;
                          // });
                        },
                        child: SizedBox(
                          width: 74,
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 37,
                                backgroundColor: const Color(0xffF3BC43),
                                child: Center(
                                  child: CircleAvatar(
                                    radius: 32,
                                    backgroundColor: Colors.black,
                                    child: Center(
                                        child: Image.asset(
                                            'assets/images/home/telescope.png')),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            index = 2;
                          });
                        },
                        child: SizedBox(
                          width: 74,
                          height: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.store_outlined,
                                size: 30,
                                color: index == 2
                                    ? const Color(0xffF3BC43)
                                    : Colors.white,
                              ),
                              Text(
                                'Market',
                                style: TextStyle(
                                  color: index == 2
                                      ? const Color(0xffF3BC43)
                                      : Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            index = 3;
                          });
                        },
                        child: SizedBox(
                          width: 74,
                          height: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.more_horiz,
                                size: 30,
                                color: index == 3
                                    ? const Color(0xffF3BC43)
                                    : Colors.white,
                              ),
                              Text(
                                'More',
                                style: TextStyle(
                                  color: index == 3
                                      ? const Color(0xffF3BC43)
                                      : Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
