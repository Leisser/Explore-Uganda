import '../../../constants/constants.dart';
import 'package:flutter/material.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        itemCount: 10,
        itemBuilder: (context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'To Do',
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

              Image.asset('assets/event.png'),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'ART',
                style: categories,
              ),
              // SizedBox(height: 5,),
              const Text(
                'Muloma’s Exhibition',
                style: subwords,
              ),
              const Text(
                'Enjoy mixed media paintings done by a recognized artist',
                style: normalText,
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 15,
                  ),
                  Text(
                    'Masindi, Uganda',
                    style: normalText,
                  )
                ],
              )
            ],
          );
        });
  }
}
