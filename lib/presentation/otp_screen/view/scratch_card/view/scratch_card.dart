import 'package:ecommerce_task/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';

class ScratchCard extends StatelessWidget {
  final VoidCallback onAddToCart;
  final String imageUrl;
  final double price;

  ScratchCard({
    super.key,
    required this.onAddToCart,
    required this.imageUrl,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Scratcher(
          brushSize: 50,
          threshold: 50,
          color: ColorTheme.backgroundclr,
          onThreshold: () {
            onAddToCart();
          },
          child: Container(
            height: 300,
            width: 300,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  imageUrl,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                Text(
                  'Price: \$${price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'Scratch to reveal your prize!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: onAddToCart,
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorTheme.text,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            'Add to Cart',
            style: TextStyle(
              fontSize: 16,
              color: ColorTheme.backgroundclr,
            ),
          ),
        ),
      ],
    );
  }
}
