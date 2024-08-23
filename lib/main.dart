import 'package:ecommerce_task/presentation/cart_screen/controller/cart_controller.dart';
import 'package:ecommerce_task/presentation/home_screen/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
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
      home: HomeScreen(),
    );
  }
}
