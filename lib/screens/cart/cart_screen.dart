import 'package:e_commerce/components/default_button.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screens/cart/components/body.dart';
import 'package:e_commerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckOurCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Column(
            children: [
              Text(
                "Your Cart",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "${cartProvider.itemCount} items",
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          );
        },
      ),
    );
  }
}

class CheckOurCard extends StatelessWidget {
  const CheckOurCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(15),
            horizontal: getProportionateScreenWidth(15),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      height: getProportionateScreenWidth(40),
                      width: getProportionateScreenWidth(40),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SvgPicture.asset("assets/icons/receipt.svg"),
                    ),
                    Spacer(),
                    Text(
                      "Add voucher code",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: kTextColor,
                    )
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Total:\n",
                        children: [
                          TextSpan(
                            text: "\$${cartProvider.totalAmount.toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(190),
                      child: DefaultButton(
                        text: "Check Out",
                        press: () {
                          if (cartProvider.itemCount > 0) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Order Confirmed!'),
                                content: Text(
                                  'Your order of ${cartProvider.itemCount} items totaling \$${cartProvider.totalAmount.toStringAsFixed(2)} has been placed successfully!',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      cartProvider.clearCart();
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Your cart is empty!'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
