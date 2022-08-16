import 'package:flutter/cupertino.dart';
import 'package:grocery/models/wishlist_model.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getWishlistItems {
    return _wishlistItems;
  }

  void addProductToWishList({required String productID}) {
    if (_wishlistItems.containsKey(productID)) {
      removeOneItem(productID);
    } else {
      _wishlistItems.putIfAbsent(
        productID,
        () =>
            WishlistModel(ID: DateTime.now().toString(), productID: productID),
      );
    }
    notifyListeners();
  }

  void removeOneItem(String productID) {
    _wishlistItems.remove(productID);
    notifyListeners();
  }

  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
