import 'package:flutter/material.dart';

class CustomAppRow extends StatefulWidget {
  const CustomAppRow({super.key});

  @override
  State<CustomAppRow> createState() => _CustomAppRowState();
}

class _CustomAppRowState extends State<CustomAppRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.person_2_outlined))
                    ],
                  );
  }
}