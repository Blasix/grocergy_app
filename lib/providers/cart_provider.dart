import 'package:flutter/cupertino.dart';
import 'package:grocery/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  void addProductsToCart({
    required String productID,
    required int quantity,
  }) {
    _cartItems.putIfAbsent(
      productID,
      () => CartModel(
        ID: DateTime.now().toString(),
        productID: productID,
        quantity: quantity,
      ),
    );
  }
}
