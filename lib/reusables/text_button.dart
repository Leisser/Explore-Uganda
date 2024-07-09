import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Adjust as needed
        ),
        padding: const EdgeInsets.symmetric(
          // horizontal:
          //     MediaQuery.of(context).size.width * 0.335, // 30% of screen width
          vertical: 15.0,
        ),
        backgroundColor: const Color(0xFFF3BC43),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
