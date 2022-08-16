import 'package:flutter/cupertino.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class HearthBTN extends StatelessWidget {
  const HearthBTN(
      {Key? key, required this.productID, this.isInWishlist = false})
      : super(key: key);
  final String productID;
  final bool? isInWishlist;
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final utils = Utils(context);
    return GestureDetector(
      onTap: () {
        wishlistProvider.addProductToWishList(productID: productID);
      },
      child: Icon(
        isInWishlist != null && isInWishlist == true
            ? IconlyBold.heart
            : IconlyLight.heart,
        size: 22,
        color: isInWishlist != null && isInWishlist == true
            ? utils.redColor
            : utils.color,
      ),
    );
  }
}
