import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class Accomodation extends StatefulWidget {
  const Accomodation({super.key});

  @override
  State<Accomodation> createState() => _AccomodationState();
}

class _AccomodationState extends State<Accomodation> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Accomodation',
              //       style: subwords,
              //     ),
              //     TextButton(
              //         onPressed: () {},
              //         child: Text(
              //           'View all',
              //           style: TextStyle(fontSize: 12),
              //         )),
              //   ],
              // ),
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
                    text: const TextSpan(text: "\$23", style: subwords, children: [
                      TextSpan(
                        text: "/night",
                      ),
                    ]),
                  )
                ],
              )
            ],
          );
        });
  }
}
