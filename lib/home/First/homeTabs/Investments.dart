import '../../../constants/constants.dart';
import 'package:flutter/material.dart';

class Investments extends StatefulWidget {
  const Investments({super.key});

  @override
  State<Investments> createState() => _InvestmentsState();
}

class _InvestmentsState extends State<Investments> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                    'Investment Options',
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
              
              
            ],
          
        
        );
      }
    );
  }
}