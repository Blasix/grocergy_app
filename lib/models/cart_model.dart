import 'package:flutter/cupertino.dart';

class CartModel extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  final String ID, productID;
  final int quantity;

  CartModel({
    // ignore: non_constant_identifier_names
    required this.ID,
    required this.productID,
    required this.quantity,
  });
}
