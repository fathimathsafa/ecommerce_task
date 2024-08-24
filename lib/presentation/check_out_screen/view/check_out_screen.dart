import 'package:ecommerce_task/core/constants/color_constants.dart';
import 'package:ecommerce_task/core/constants/text_style_constatnts.dart';
import 'package:ecommerce_task/presentation/payment_screen/view/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_task/presentation/home_screen/model/product_model.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Product> products;

  CheckoutScreen({required this.products});

  double _calculateTotalPrice(List<Product> products) {
    return products.fold(
        0.0, (sum, product) => sum + (product.price * product.quantity));
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = _calculateTotalPrice(products);

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
        title: Text(
          "CHECK OUT",
          style: GlTextStyles.robotoStyl(),
        ),
      ),
      body: products.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(
                  fontSize: 18,
                  color: ColorTheme.black,
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 3,
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
                                      '₹${product.price.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: ColorTheme.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'x${product.quantity}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorTheme.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Total Price: ₹${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: ColorTheme.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: ColorTheme.text,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(products: products),
                          ),
                        );
                      },
                      child: Text(
                        'BUY NOW',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorTheme.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
