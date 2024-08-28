// import 'dart:async';
// import 'package:ecommerce_task/core/constants/color_constants.dart';
// import 'package:ecommerce_task/core/constants/text_style_constatnts.dart';
// import 'package:ecommerce_task/presentation/registration_screen/view/registration_screen.dart';
// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => RegistrationScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorTheme.backgroundclr,
//       body: Center(
//         child: Text('BAG NEST',
//             style: GlTextStyles.robotoStyl(size: 30, weight: FontWeight.bold)),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_task/core/constants/color_constants.dart';
import 'package:ecommerce_task/core/constants/text_style_constatnts.dart';
import 'package:ecommerce_task/presentation/home_screen/view/home_screen.dart';
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
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    // Delay to show splash screen
    await Future.delayed(Duration(seconds: 3));

    // Check if user is already logged in
    if (FirebaseAuth.instance.currentUser != null) {
      // User is logged in, navigate to HomeScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // User is not logged in, navigate to RegistrationScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => RegistrationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.backgroundclr,
      body: Center(
        child: Text(
          'BAG NEST',
          style: GlTextStyles.robotoStyl(size: 30, weight: FontWeight.bold),
        ),
      ),
    );
  }
}
