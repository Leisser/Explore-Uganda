import 'package:flutter/material.dart';

class CustomTextSignUpInput extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final bool showObscurer;
  final TextInputType textInputType;
  final TextInputAction textInputAction;

  const CustomTextSignUpInput(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.controller,
      this.showObscurer = true,
      this.textInputType = TextInputType.text,
      this.textInputAction = TextInputAction.done});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        textInputAction: textInputAction,
        obscureText: showObscurer,
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Color(0xFFF3BC43),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Color(0xFF555454)),
          ),
          fillColor: const Color(0x00555454), // Transparent fill color
          focusColor: const Color(0x00555454), // Transparent focus color
          filled: true, // Needed for selection color
        ),
        cursorColor: Colors.black, // Set selection color
      ),
    );
  }
}
