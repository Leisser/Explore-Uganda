
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/constants.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  String selectedCurrency = 'USD';
  final List<Map<String, String>> currencies = [
    {'code': 'USD', 'flag': 'assets/us.svg'},
    {'code': 'EUR', 'flag': 'assets/europe.svg'},
    {'code': 'GBP', 'flag': 'assets/uk.svg'},
    {'code': 'UGX', 'flag': 'assets/ug.svg'},
  ];

  String getFlag(String currencyCode) {
    return currencies
        .firstWhere((currency) => currency['code'] == currencyCode)['flag']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: bpadding,
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Textfieldcolor,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(30))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_outlined))
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 10, left: 20),
                  child: Text(
                    'Currency Converter',
                    style: subheadings,
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: bpadding,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: appcolor, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Currency dropdown
                                // Currency dropdown
                                DropdownButton<String>(
                                  value: selectedCurrency,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedCurrency = newValue!;
                                    });
                                  },
                                  items: currencies
                                      .map<DropdownMenuItem<String>>(
                                          (Map<String, String> currency) {
                                    return DropdownMenuItem<String>(
                                      value: currency['code'],
                                      child: Row(
                                        children: [
                                          
                                          SvgPicture.asset(
                                            currency['flag']!,
                                            width: 30,
                                            height: 30,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            currency['code']!,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              
                                const Text('1', style: subwords,)
                              ],
                            ),
                          ),
                        ),
                      
                    
                  ]))
        ],
      ),
    );
  }
}
