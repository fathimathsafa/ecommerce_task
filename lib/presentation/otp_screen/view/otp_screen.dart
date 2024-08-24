import 'dart:developer';
import 'package:ecommerce_task/core/constants/color_constants.dart';
import 'package:ecommerce_task/core/constants/text_style_constatnts.dart';
import 'package:ecommerce_task/presentation/home_screen/view/home_screen.dart';
import 'package:ecommerce_task/presentation/cart_screen/controller/cart_controller.dart';
import 'package:ecommerce_task/presentation/home_screen/model/product_model.dart';
import 'package:ecommerce_task/presentation/otp_screen/view/scratch_card/view/scratch_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();
  bool showScratchCard = false;

  final product = Product(
    name: "HAND BAG",
    price: 49.99, // Update price as needed
    imageUrl:
        'https://media.istockphoto.com/id/1204235743/photo/stylish-fashionable-woman-with-orange-round-bag.webp?b=1&s=612x612&w=0&k=20&c=KG95k0zw49LTxC7uxyyKCw88GhaybjhVIxRZjBVbgak=',
    description: "A stylish hand bag.",
    quantity: 1,
    id: '',
  );

  void addProductToCart() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.addProduct(product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product added to cart.')),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false,
    );
  }

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
        setState(() {
          showScratchCard = true;
        });
      } else {
        log('User sign-in failed.');
      }
    } catch (e) {
      log('Error verifying OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
      setState(() {
        showScratchCard = true; // Show scratch card even on failure
      });
    }
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
            if (showScratchCard)
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: size.height * 0.05),
                    child: ScratchCard(
                      onAddToCart: addProductToCart,
                      imageUrl: product.imageUrl,
                      price: product.price,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: addProductToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorTheme.text,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Add to Cart',
                      style: GlTextStyles.robotoStyl(
                          size: 16, color: ColorTheme.backgroundclr),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
