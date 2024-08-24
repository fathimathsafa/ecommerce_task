import 'package:ecommerce_task/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';

class ScratchCard extends StatelessWidget {
  final VoidCallback onAddToCart;

  ScratchCard({super.key, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Scratcher(
      brushSize: 50,
      threshold: 50,
      color: ColorTheme.backgroundclr,
      onThreshold: () {
        onAddToCart();
      },
      child: Container(
        height: 300,
        width: 300,
        color: ColorTheme.backgroundclr,
        alignment: Alignment.center,
        child: Text(
          'Congratulations! You won a free bag.',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
