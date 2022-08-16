import 'package:flutter/cupertino.dart';

class WishlistModel extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  final String ID, productID;

  WishlistModel({
    // ignore: non_constant_identifier_names
    required this.ID,
    required this.productID,
  });
}
