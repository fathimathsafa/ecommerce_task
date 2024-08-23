import 'package:ecommerce_task/core/constants/color_constants.dart';
import 'package:ecommerce_task/core/constants/text_style_constatnts.dart';
import 'package:ecommerce_task/presentation/cart_screen/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_task/presentation/home_screen/model/product_model.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  DetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final cartProvider = Provider.of<CartProvider>(context);

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
          product.name,
          style: GlTextStyles.robotoStyl(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * .5,
              width: size.width * .9,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(product.imageUrl), fit: BoxFit.fill)),
            ),
            Text(
              product.name,
              style: GlTextStyles.robotoStyl(),
            ),
            Text(
              '₹${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16.0,
                color: ColorTheme.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                product.description,
                style: GlTextStyles.robotoStyl(),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width * .2,
                ),
                ElevatedButton(
                  onPressed: () {
                    cartProvider.addProduct(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart'),
                      ),
                    );
                  },
                  child: Text(
                    'ADD TO CART',
                    style: TextStyle(color: ColorTheme.backgroundclr),
                  ),
                ),
                SizedBox(
                  width: size.width * .2,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    ' BUY NOW ',
                    style: TextStyle(color: ColorTheme.backgroundclr),
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
