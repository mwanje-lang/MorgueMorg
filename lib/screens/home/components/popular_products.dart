import 'package:e_commerce/components/product_card.dart';
import 'package:e_commerce/models/Product.dart';
import 'package:e_commerce/screens/details/details_screen.dart';
import 'package:e_commerce/screens/home/components/section_title.dart';
import 'package:e_commerce/size_config.dart';
import 'package:flutter/material.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          text: "Popular Products",
          press: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('View all popular products'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoProducts.length,
                (index) {
                  if (demoProducts[index].isPopular)
                    return ProductCard(
                      product: demoProducts[index],
                      press: () => Navigator.pushNamed(
                        context,
                        DetailsScreen.routeName,
                        arguments: ProductDetailsArguments(
                          product: demoProducts[index],
                        ),
                      ),
                    );

                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(
                width: getProportionateScreenWidth(20),
              )
            ],
          ),
        ),
      ],
    );
  }
}
