import 'dart:developer';
import 'package:ecommerce_task/core/constants/color_constants.dart';
import 'package:ecommerce_task/core/constants/text_style_constatnts.dart';
import 'package:ecommerce_task/presentation/login_screen/view/login_screen.dart';
import 'package:ecommerce_task/presentation/otp_screen/view/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final phoneNumberController = TextEditingController();
    final nameController = TextEditingController();

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
            SizedBox(height: size.height * 0.06),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: TextFormField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                validator: (name) {
                  if (name!.isEmpty) {
                    return "Enter a valid Username";
                  }
                  return null;
                },
                style: TextStyle(color: ColorTheme.backgroundclr),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: ColorTheme.black),
                  filled: true,
                  fillColor: ColorTheme.text,
                  hintText: 'Name',
                  hintStyle: GlTextStyles.hintstyle(size: 15),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: TextFormField(
                controller: phoneNumberController,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: ColorTheme.backgroundclr),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone, color: ColorTheme.black),
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
            SizedBox(height: size.height * 0.05),
            InkWell(
              onTap: () async {
                try {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: phoneNumberController.text,
                    verificationCompleted: (phoneAuthCredential) {},
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
                          builder: (context) => OtpScreen(verificationId: verificationId),
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
                    "SEND",
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
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                "Already have an account? Login",
                style: GlTextStyles.robotoStyl(size: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
