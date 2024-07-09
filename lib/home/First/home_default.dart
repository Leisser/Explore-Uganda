import 'package:explore_uganda/value_notifier/value_notifier.dart';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../customComponents/CustomAppRow.dart';
import 'homeTabs/Accomodation.dart';
import 'homeTabs/All.dart';
import 'homeTabs/Attractions.dart';
import 'homeTabs/Investments.dart';

class HomeDefault extends StatefulWidget {
  const HomeDefault({super.key});

  @override
  State<HomeDefault> createState() => _HomeDefaultState();
}

class _HomeDefaultState extends State<HomeDefault>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    tabPageIndex.addListener(() {
      setState(() {
        _tabController.index = tabPageIndex.value;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Find your destination',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            CustomAppRow()
          ]),
          TabBar(
            dividerColor: Colors.transparent,
            controller: _tabController,
            indicatorColor: Colors.transparent,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            unselectedLabelColor: Colors.black87,
            labelColor: appcolor,
            onTap: (value) {
              tabPageIndex.value = _tabController.index;
            },
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Attractions'),
              Tab(text: 'Accommodation'),
              Tab(text: 'Investments'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                All(),
                Attractions(),
                Accomodation(),
                Investments(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
