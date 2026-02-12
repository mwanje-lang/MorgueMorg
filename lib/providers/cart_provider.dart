import 'package:flutter/foundation.dart';
import 'package:e_commerce/models/Cart.dart';
import 'package:e_commerce/models/Product.dart';

class CartProvider with ChangeNotifier {
  final List<Cart> _cartItems = [];

  List<Cart> get cartItems => _cartItems;

  int get itemCount => _cartItems.length;

  double get totalAmount {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.product.price * item.numOfItems;
    }
    return total;
  }

  void addToCart(Product product, int quantity, int selectedColorIndex) {
    // Check if product already exists in cart
    final existingIndex = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      // Update quantity if product already exists
      _cartItems[existingIndex] = Cart(
        product: product,
        numOfItems: _cartItems[existingIndex].numOfItems + quantity,
      );
    } else {
      // Add new item to cart
      _cartItems.add(Cart(
        product: product,
        numOfItems: quantity,
      ));
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void updateQuantity(int productId, int newQuantity) {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (newQuantity <= 0) {
        removeFromCart(productId);
      } else {
        _cartItems[index] = Cart(
          product: _cartItems[index].product,
          numOfItems: newQuantity,
        );
        notifyListeners();
      }
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
