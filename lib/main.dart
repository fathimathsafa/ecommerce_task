import 'package:ecommerce_task/presentation/cart_screen/controller/cart_controller.dart';
import 'package:ecommerce_task/presentation/splash_screen/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDpzlut-Wf7ONzy_RzPZZ3WDXo3TLbjarg",
          appId: "1:793206883976:android:73d6512c37630602c4413d",
          messagingSenderId: "",
          projectId: "bagnest-d5594"));
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
