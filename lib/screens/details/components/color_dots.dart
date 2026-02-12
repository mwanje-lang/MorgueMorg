import 'package:e_commerce/components/rounded_icon_btn.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/Product.dart';
import 'package:e_commerce/size_config.dart';
import 'package:flutter/material.dart';

class ColorDots extends StatefulWidget {
  const ColorDots({
    super.key,
    required this.product,
    required this.onColorChanged,
    required this.onQuantityChanged,
  });

  final Product product;
  final Function(int) onColorChanged;
  final Function(int) onQuantityChanged;

  @override
  State<ColorDots> createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  int selectedColor = 0;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
            widget.product.colors.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
                widget.onColorChanged(index);
              },
              child: ColorDot(
                color: widget.product.colors[index],
                isSelected: selectedColor == index,
              ),
            ),
          ),
          Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {
              if (quantity > 1) {
                setState(() {
                  quantity--;
                });
                widget.onQuantityChanged(quantity);
              }
            },
          ),
          SizedBox(width: getProportionateScreenWidth(15)),
          Text(
            quantity.toString(),
            style: TextStyle(
              fontSize: getProportionateScreenWidth(16),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(15)),
          RoundedIconBtn(
            icon: Icons.add,
            press: () {
              setState(() {
                quantity++;
              });
              widget.onQuantityChanged(quantity);
            },
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    super.key,
    required this.color,
    this.isSelected = false,
  });

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(8),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        // color: product.colors[0],
        shape: BoxShape.circle,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
