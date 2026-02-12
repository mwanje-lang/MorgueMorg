import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return IconBtnWithCounter(
                svgSrc: "assets/icons/Cart Icon.svg",
                numOfitem: cartProvider.itemCount,
                press: () => Navigator.pushNamed(context, CartScreen.routeName),
              );
            },
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 3,
            press: () {},
          ),
        ],
      ),
    );
  }
}
