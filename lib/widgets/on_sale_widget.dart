import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/services/utils.dart';
import 'package:grocery/widgets/price_widget.dart';
import 'package:grocery/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../constants/firebase_consts.dart';
import '../inner_screens/product_details.dart';
import '../models/products_model.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../services/global_methods.dart';
import 'heart_btn.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.id);
    bool? isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        color: utils.getTheme
            ? Theme.of(context).cardColor.withOpacity(0.9)
            : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: FancyShimmerImage(
                          imageUrl: productModel.imageUrl,
                          width: utils.screenSize.width * 0.3,
                          boxFit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Column(
                        children: [
                          TextWidget(
                            text: '1${productModel.isPiece ? 'P' : 'KG'}',
                            color: utils.color,
                            textSize: 22,
                            isTitle: true,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: isInCart
                                    ? null
                                    : () {
                                        final User? user =
                                            authInstance.currentUser;
                                        if (user == null) {
                                          GlobalMethods.errorDialog(
                                              subtitle:
                                                  'No user found please login first',
                                              context: context);
                                          return;
                                        }
                                        cartProvider.addProductsToCart(
                                          productID: productModel.id,
                                          quantity: 1,
                                        );
                                      },
                                child: Icon(
                                  isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
                                  size: 22,
                                  color:
                                      isInCart ? utils.blueColor : utils.color,
                                ),
                              ),
                              HearthBTN(
                                productID: productModel.id,
                                isInWishlist: isInWishlist,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                PriceWidget(
                    isOnSale: productModel.isOnSale,
                    price: productModel.price,
                    salePrice: productModel.salePrice,
                    textPrice: '1'),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                  text: productModel.title,
                  color: utils.color,
                  textSize: 16,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
