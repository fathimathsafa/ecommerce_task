import 'package:ecommerce_task/core/constants/color_constants.dart';
import 'package:ecommerce_task/presentation/cart_screen/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_task/presentation/cart_screen/model/cart_model.dart';
import 'package:ecommerce_task/presentation/check_out_screen/view/check_out_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            Navigator.pop(context);
          },
        ),
        backgroundColor: ColorTheme.backgroundclr,
        title: Text("CART"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProducts.length,
              itemBuilder: (context, index) {
                final product = cartProducts[index];
                return ListTile(
                  tileColor:
                      ColorTheme.text, 
                  textColor: ColorTheme.backgroundclr, 
                  iconColor: ColorTheme.backgroundclr, 
                  leading: Image.network(product.imageUrl),
                  title: Text(product.name),
                  subtitle: Text('₹${product.price}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      cartProvider.removeProduct(product);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Total Price: ₹${totalPrice.toStringAsFixed(2)}'),
                SizedBox(height: 10),
                ElevatedButton(
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
                    'Proceed to Checkout',
                    style: TextStyle(color: ColorTheme.backgroundclr),
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
