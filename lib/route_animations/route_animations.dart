import 'package:flutter/material.dart';

PageRouteBuilder fadeTransitionBuilder(Widget child) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final opacity = animation.drive(
          Tween<double>(begin: 0, end: 1),
        );

        return FadeTransition(opacity: opacity, child: child);
      });
}

PageRouteBuilder slideTransitionBuilder(Widget child) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final position = animation.drive(
          Tween<Offset>(begin: const Offset(-1, 1), end: const Offset(0, 0)),
        );

        return SlideTransition(position: position, child: child);
      });

  // left to right: begin: Offset(-1,0) end: Offset(0,0)
  // right to left: begin: Offset(1,0) end: Offset(0,0)
  // bottom to top: begin: Offset(0,1) end: Offset(0,0)
  // top to bottmo: begin: Offset(0,-1) end: Offset(0,0)
  // from top right corner: begin: Offset(1,-1) end: Offset(0,0)
  // from bottom right corner: begin: Offset(1,1) end: Offset(0,0)
  // from top left corner: begin: Offset(-1,-1) end: Offset(0,0)
  // from bottom left corner: begin: Offset(-1,1) end: Offset(0,0)
}

PageRouteBuilder scaleTransitionBuilder(Widget child) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final scale = animation.drive(
          Tween<double>(begin: 0, end: 1),
        );

        return ScaleTransition(scale: scale, child: child);
      });
}