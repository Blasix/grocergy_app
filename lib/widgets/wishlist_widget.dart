import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/inner_screens/product_details.dart';
import 'package:grocery/models/wishlist_model.dart';
import 'package:grocery/providers/product_provider.dart';
import 'package:grocery/services/global_methods.dart';
import 'package:grocery/services/utils.dart';
import 'package:grocery/widgets/heart_btn.dart';
import 'package:grocery/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistModel = Provider.of<WishlistModel>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProduct =
        productProvider.findProdById(wishlistModel.productID);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(wishlistModel.productID);
    bool? isInCart =
        cartProvider.getCartItems.containsKey(wishlistModel.productID);
    final Color color = Utils(context).color;
    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetails.routeName,
              arguments: wishlistModel.productID);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Utils(context).getTheme
                  ? Theme.of(context).cardColor.withOpacity(0.9)
                  : Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: FancyShimmerImage(
                        height: 90,
                        imageUrl: getCurrentProduct.imageUrl,
                        boxFit: BoxFit.contain,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: isInCart
                                  ? null
                                  : () {
                                      cartProvider.addProductsToCart(
                                        productID: wishlistModel.productID,
                                        quantity: 1,
                                      );
                                    },
                              child: Icon(
                                isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
                                size: 22,
                                color: isInCart
                                    ? Utils(context).blueColor
                                    : Utils(context).color,
                              ),
                            ),
                            HearthBTN(
                              productID: wishlistModel.productID,
                              isInWishlist: isInWishlist,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: TextWidget(
                            text: '€${usedPrice.toStringAsFixed(2)}',
                            color: color,
                            textSize: 20,
                            isTitle: true,
                          ),
                        ),
                        TextWidget(
                          text:
                              '/${getCurrentProduct.isPiece ? 'Piece' : 'KG'}',
                          color: color,
                          textSize: 16,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Center(
                  child: FittedBox(
                    child: TextWidget(
                      text: getCurrentProduct.title,
                      color: color,
                      textSize: 20,
                      isTitle: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
