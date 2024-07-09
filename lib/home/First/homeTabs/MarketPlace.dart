import '../../../constants/constants.dart';
import 'package:flutter/material.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({super.key});

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Market Place',
                style: subwords,
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View all',
                    style: TextStyle(fontSize: 12),
                  )),
            ],
          ),
          const SizedBox(
            height: 5,
          ),

          Image.asset('assets/market.png'),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'MARKET PLACE',
            style: categories,
          ),
          // SizedBox(height: 5,),
          const Text(
            'Hotels, Events, Tours, Car and Air travel',
            style: subwords,
          ),

          const Row(
            children: [
              Icon(
                Icons.star,
                size: 15,
              ),
              Text(
                '4.1',
                style: normalText,
              ),
              Text(
                '(121 reviews)',
                style: normalText,
              )
            ],
          ),
        ],
      ),
    );
  }
}
