import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_task/core/constants/color_constants.dart';
import 'package:ecommerce_task/core/constants/text_style_constatnts.dart';
import 'package:ecommerce_task/presentation/cart_screen/controller/cart_controller.dart';
import 'package:ecommerce_task/presentation/cart_screen/model/cart_model.dart';
import 'package:ecommerce_task/presentation/check_out_screen/view/check_out_screen.dart';
import 'package:ecommerce_task/presentation/home_screen/view/home_screen.dart'; // Import your home screen

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final cartProducts = cartProvider.cart;
    final totalPrice = cartProvider.totalPrice;

    return Scaffold(
      backgroundColor: ColorTheme.backgroundclr,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ColorTheme.white,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with your home screen
              ModalRoute.withName('/'), // Clear all previous routes
            );
          },
        ),
        backgroundColor: ColorTheme.backgroundclr,
        title: Text(
          "CART",
          style: GlTextStyles.robotoStyl(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: cartProducts.length,
              itemBuilder: (context, index) {
                final product = cartProducts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Image.network(
                          product.imageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: ColorTheme.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '₹${product.price}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ColorTheme.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_shopping_cart,
                              color: ColorTheme.black),
                          onPressed: () {
                            cartProvider.removeProduct(product);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: size.width * 0.1,
                ),
                MaterialButton(
                  onPressed: () {},
                  color: ColorTheme.text,
                  child: Text(
                    'TOTAL: ₹${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.15,
                ),
                MaterialButton(
                  color: ColorTheme.text,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutScreen(
                          products: cartProducts,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'CHECK OUT',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorTheme.black,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
