import 'package:flutter/material.dart';

class CustomSignInButton extends StatelessWidget {
  final String text;
  final String textLink;
  final VoidCallback onPressed;

  const CustomSignInButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.textLink,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: onPressed,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    offset: const Offset(0, 4), // Adjust shadow position
                    blurRadius: 4.0, // Adjust shadow blur
                  ),
                ],
              ),
              child: TextButton(
                
                onPressed: () {},
                child: Padding(
                  padding:
                      const EdgeInsets.all(10.0), // Adjust padding as needed
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Google logo
                      Image.asset(
                        textLink,
                        height: 20.0, // Adjust logo size
                        width: 20.0, // Adjust logo size
                      ),
                      Text(
                        text,
                        style: const TextStyle(
                            color: Color(0xFF1B1919),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Colored border (optional)
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter, // Align to top-left
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: const Color(0xFFF3BC43),
                      width: 1.0, // Adjust border width
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
