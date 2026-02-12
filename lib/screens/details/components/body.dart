import 'package:e_commerce/components/default_button.dart';
import 'package:e_commerce/models/Product.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screens/details/components/color_dots.dart';
import 'package:e_commerce/screens/details/components/product_description.dart';
import 'package:e_commerce/screens/details/components/product_images.dart';
import 'package:e_commerce/screens/details/components/top_rounded_container.dart';
import 'package:e_commerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final Product product;

  const Body({super.key, required this.product});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedColorIndex = 0;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImages(product: widget.product),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: widget.product,
                  pressOneSeeMore: () {
                    // Show a dialog with full description
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(widget.product.title),
                        content: Text(widget.product.description),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                TopRoundedContainer(
                  color: Color(0xFFF6F7F9),
                  child: Column(
                    children: [
                      ColorDots(
                        product: widget.product,
                        onColorChanged: (colorIndex) {
                          setState(() {
                            selectedColorIndex = colorIndex;
                          });
                        },
                        onQuantityChanged: (newQuantity) {
                          setState(() {
                            quantity = newQuantity;
                          });
                        },
                      ),
                      TopRoundedContainer(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.15,
                            right: SizeConfig.screenWidth * 0.15,
                            top: getProportionateScreenWidth(15),
                            bottom: getProportionateScreenWidth(40),
                          ),
                          child: DefaultButton(
                            text: "Add to Cart",
                            press: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .addToCart(
                                widget.product,
                                quantity,
                                selectedColorIndex,
                              );
                              
                              // Show confirmation snackbar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Added to cart!'),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
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
