import 'dart:async';
import 'package:ecommerce_task/core/constants/color_constants.dart';
import 'package:ecommerce_task/core/constants/text_style_constatnts.dart';
import 'package:ecommerce_task/presentation/registration_screen/view/registration_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => RegistrationScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.backgroundclr,
      body: Center(
        child: Text('BAG NEST',
            style: GlTextStyles.robotoStyl(size: 30, weight: FontWeight.bold)),
      ),
    );
  }
}
