
import '../../../constants/constants.dart';
import 'package:flutter/material.dart';

class reusableButton extends StatefulWidget {

  final String text;
  final IconData? icon;
  final VoidCallback onPressed;

  const reusableButton({super.key, 
    required this.text,
    this.icon,
    required this.onPressed, 
  });

  @override
  State<reusableButton> createState() => _reusableButtonState();
}

class _reusableButtonState extends State<reusableButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: appcolor, // Background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
        ),
        onPressed: widget.onPressed,
        icon: widget.icon != null ? Icon(widget.icon, size: 20) : null, // Icon size
        label: Text(widget.text, style: subwords), // Text size
      ),
    );

  }
}