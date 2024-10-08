import 'dart:developer';
import 'package:ecommerce_task/presentation/home_screen/view/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_task/core/constants/color_constants.dart';
import 'package:ecommerce_task/core/constants/text_style_constatnts.dart';
import 'package:ecommerce_task/presentation/otp_screen/view/otp_screen.dart';
import 'package:ecommerce_task/presentation/registration_screen/view/registration_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: ColorTheme.backgroundclr,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.1),
            Text(
              "WELCOME BACK TO BAG NEST",
              style: GlTextStyles.robotoStyl(),
            ),
            SizedBox(height: size.height * 0.2),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * .1, right: size.width * .1),
              child: TextFormField(
                controller: phoneController,
                textInputAction: TextInputAction.next,
                validator: (name) {
                  if (name!.isEmpty) {
                    return "Enter a valid phone number";
                  } else {
                    return null;
                  }
                },
                style: TextStyle(color: ColorTheme.backgroundclr),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone,
                    color: ColorTheme.black,
                  ),
                  filled: true,
                  fillColor: ColorTheme.text,
                  hintText: 'Phone Number',
                  hintStyle: GlTextStyles.hintstyle(size: 15),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.07),
            InkWell(
              onTap: () async {
                try {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: phoneController.text,
                    verificationCompleted: (phoneAuthCredential) {
                      // Auto verification succeeded, sign in directly
                      FirebaseAuth.instance
                          .signInWithCredential(phoneAuthCredential);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false,
                      );
                    },
                    verificationFailed: (error) {
                      log('Verification failed: ${error.message}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Verification failed')),
                      );
                    },
                    codeSent: (verificationId, forceResendingToken) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OtpScreen(verificationId: verificationId),
                        ),
                      );
                    },
                    codeAutoRetrievalTimeout: (verificationId) {
                      log("Auto retrieval timeout");
                    },
                  );
                } catch (e) {
                  log('Error during phone number verification: $e');
                }
              },
              child: Container(
                height: size.height * 0.06,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                  color: ColorTheme.text,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "LOGIN",
                    style: GlTextStyles.hintstyle(
                      size: 15,
                      color: ColorTheme.backgroundclr,
                      weight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.3),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrationScreen(),
                  ),
                );
              },
              child: Text(
                "Don't have an account? Register",
                style: GlTextStyles.robotoStyl(size: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
