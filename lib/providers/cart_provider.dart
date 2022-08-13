import 'package:flutter/cupertino.dart';
import 'package:grocery/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};

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
    notifyListeners();
  }

  void reduceQuantityByOne(String productID) {
    _cartItems.update(
      productID,
      (value) => CartModel(
        ID: value.ID,
        productID: productID,
        quantity: value.quantity - 1,
      ),
    );
    notifyListeners();
  }

  void increaseQuantityByOne(String productID) {
    _cartItems.update(
      productID,
      (value) => CartModel(
        ID: value.ID,
        productID: productID,
        quantity: value.quantity + 1,
      ),
    );
    notifyListeners();
  }

  void removeOneItem(String productID) {
    _cartItems.remove(productID);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
