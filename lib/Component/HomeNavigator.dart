import 'package:flutter/material.dart';

class HomeNavigator extends StatelessWidget {
  HomeNavigator({Key? key, required this.child, required this.onPressed}) : super(key: key);

  VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(16), color: Theme.of(context).colorScheme.primaryContainer, boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withAlpha(130),
            blurRadius: 8.0, // soften the shadow
            spreadRadius: 4.0, //extend the shadow
            offset: const Offset(
              8.0, // Move to right 10  horizontally
              8.0, // Move to bottom 10 Vertically
            ),
          ),
          BoxShadow(
            color: Colors.white.withAlpha(130),
            blurRadius: 8.0, // soften the shadow
            spreadRadius: 4.0, //extend the shadow
            offset: const Offset(
              -8.0, // Move to right 10  horizontally
              -8.0, // Move to bottom 10 Vertically
            ),
          ),
        ]),
        child: child,
      ),
    );
  }
}
