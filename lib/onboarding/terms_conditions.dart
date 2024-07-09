import 'package:explore_uganda/default_export.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Terms and Conditions of Use',
            style: boldTexts,
          ),
          const SizedBox(height: 16.0),
          const Text(
            'These terms and conditions outline the rules and regulations for the use of Explore Uganda mobile application.',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16.0),
          const Text(
            'By accessing this mobile application, we assume you accept these terms and conditions in full. Do not continue to use Explore Uganda mobile application if you do not accept all of the terms and conditions stated on this page.',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16.0),
          Text(
            'License',
            style: boldTexts,
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Unless otherwise stated, Explore Uganda and/or its licensors own the intellectual property rights for all material on Explore Uganda. All intellectual property rights are reserved. You may access this from Explore Uganda for your own personal use subjected to restrictions set in these terms and conditions.',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16.0),
          Text(
            'Restrictions',
            style: boldTexts,
          ),
          const SizedBox(height: 8.0),
          const Text(
            'You are specifically restricted from all of the following:',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 8.0),
          _buildRestrictionList(),
          const SizedBox(height: 16.0),
          Text(
            'Disclaimer',
            style: boldTexts,
          ),
          const SizedBox(height: 8.0),
          const Text(
            'This mobile application is provided "as is," with all faults, and Explore Uganda expresses no representations or warranties, of any kind related to this mobile application or the materials contained on this mobile application. Also, nothing contained on this mobile application shall be interpreted as advising you.',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16.0),
          Text(
            'Limitation of Liability',
            style: boldTexts,
          ),
          const SizedBox(height: 8.0),
          const Text(
            'In no event shall Explore Uganda, nor any of its officers, directors, and employees, be held liable for anything arising out of or in any way connected with your use of this mobile application, whether such liability is under contract. Explore Uganda, including its officers, directors, and employees shall not be held liable for any indirect, consequential, or special liability arising out of or in any way related to your use of this mobile application.',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16.0),
          Text(
            'Indemnification',
            style: boldTexts,
          ),
          const SizedBox(height: 8.0),
          const Text(
            'You hereby indemnify to the fullest extent Explore Uganda from and against any and/or all liabilities, costs, demands, causes of action, damages, and expenses arising in any way related to your breach of any of the provisions of these terms.',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16.0),
          Text(
            'Severability',
            style: boldTexts,
          ),
          const SizedBox(height: 8.0),
          const Text(
            'If any provision of these terms is found to be invalid under any applicable law, such provisions shall be deleted without affecting the remaining provisions herein.',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16.0),
          Text(
            'Variation of Terms',
            style: boldTexts,
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Explore Uganda is permitted to revise these terms at any time as it sees fit, and by using this mobile application you are expected to review these terms on a regular basis.',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16.0),
          Text(
            'Governing Law & Jurisdiction',
            style: boldTexts,
          ),
          const SizedBox(height: 8.0),
          const Text(
            'These terms will be governed by and construed in accordance with the laws of Uganda, and you submit to the non-exclusive jurisdiction of the state and federal courts located in Uganda for the resolution of any disputes.',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16.0),
        ]),
      ),
    );
  }
}

Widget _buildRestrictionList() {
  return const Column(
    children: [
      Text(
        '- Publishing any Explore Uganda material in any other media.',
        textAlign: TextAlign.justify,
      ),
      SizedBox(height: 4.0),
      Text(
        '- Selling, sub-licensing, and/or otherwise commercializing any Explore Uganda material.',
        textAlign: TextAlign.justify,
      ),
      SizedBox(height: 4.0),
      Text(
        '- Using this mobile application in any way that is or may be damaging to Explore Uganda.',
        textAlign: TextAlign.justify,
      ),
      SizedBox(height: 4.0),
      Text(
        '- Using this mobile application in any way that impacts user access to Explore Uganda.',
        textAlign: TextAlign.justify,
      ),
      SizedBox(height: 4.0),
      Text(
        '- Using this mobile application contrary to applicable laws and regulations, or in any way may cause harm to the mobile application, or to any person or business entity.',
        textAlign: TextAlign.justify,
      ),
    ],
  );
}
