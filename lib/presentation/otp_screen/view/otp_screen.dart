import 'dart:developer';
import 'package:ecommerce_task/core/constants/color_constants.dart';
import 'package:ecommerce_task/core/constants/text_style_constatnts.dart';
import 'package:ecommerce_task/presentation/cart_screen/controller/cart_controller.dart';
import 'package:ecommerce_task/presentation/cart_screen/view/cart_screen.dart';
import 'package:ecommerce_task/presentation/home_screen/model/product_model.dart';
import 'package:ecommerce_task/presentation/home_screen/view/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scratcher/scratcher.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();

  Future<void> verifyOtp() async {
    final otp = otpController.text.trim();
    log('OTP entered: $otp');

    if (otp.isEmpty) {
      log('OTP field is empty');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter the OTP.')),
      );
      return;
    }

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        log('User signed in: ${user.uid}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP Verified')),
        );

        _showScratchCardDialog(context);
      } else {
        log('User sign-in failed.');
      }
    } catch (e) {
      log('Error verifying OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
    }
  }

  void _showScratchCardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: 300, // Set a fixed width for the dialog content
            child: ScratchCard(
              onAddToCart: () {
                _addToCart(context);
              },
              imageUrl:
                  'https://media.istockphoto.com/id/1204235743/photo/stylish-fashionable-woman-with-orange-round-bag.webp?b=1&s=612x612&w=0&k=20&c=KG95k0zw49LTxC7uxyyKCw88GhaybjhVIxRZjBVbgak=',
              price: 0.00,
            ),
          ),
        );
      },
    );
  }

  void _addToCart(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final product = Product(
      name: "HAND BAG",
      price: 0.0,
      imageUrl:
          'https://media.istockphoto.com/id/1204235743/photo/stylish-fashionable-woman-with-orange-round-bag.webp?b=1&s=612x612&w=0&k=20&c=KG95k0zw49LTxC7uxyyKCw88GhaybjhVIxRZjBVbgak=',
      description: "A stylish hand bag.",
      quantity: 1,
      id: '',
    );

    cartProvider.addProduct(product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product added to cart.')),
    );

    Navigator.of(context).pop();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartScreen()),
    ).then((_) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: ColorTheme.backgroundclr,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.2),
            Text(
              "WELCOME TO BAG NEST",
              style: GlTextStyles.robotoStyl(),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              'Enter your OTP',
              style: GlTextStyles.robotoStyl(size: 20),
            ),
            SizedBox(height: size.height * 0.09),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: TextFormField(
                controller: otpController,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: ColorTheme.backgroundclr),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorTheme.text,
                  hintText: 'Enter OTP',
                  hintStyle: GlTextStyles.hintstyle(size: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            ElevatedButton(
              onPressed: verifyOtp,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorTheme.text,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Verify OTP',
                style: GlTextStyles.robotoStyl(
                    size: 16, color: ColorTheme.backgroundclr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    return Container(
      width: 300,  // Set a fixed width for the ScratchCard
      height: 350, // Set a fixed height for the ScratchCard
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Scratcher(
            brushSize: 50,
            threshold: 50,
            color: ColorTheme.backgroundclr,
            onThreshold: () {
              onAddToCart();
            },
            child: Container(
              height: 200, // Adjust the height as needed
              width: 200,  // Adjust the width as needed
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    imageUrl,
                    height: 100,  // Adjust image size if necessary
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Price: \$${price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Scratch to reveal your prize!',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
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
      ),
    );
  }
}
