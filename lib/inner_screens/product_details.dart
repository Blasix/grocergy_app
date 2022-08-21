import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/widgets/heart_btn.dart';
import 'package:grocery/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../constants/firebase_consts.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../providers/viewed_provider.dart';
import '../providers/wishlist_provider.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _currentValue = 1;
  @override
  @override
  Widget build(BuildContext context) {
    if (_currentValue == 0) {
      setState(() {
        _currentValue++;
      });
    }
    if (_currentValue == 100) {
      setState(() {
        _currentValue--;
      });
    }
    final utils = Utils(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final productID = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrentProduct = productProvider.findProdById(productID);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final viewedProvider = Provider.of<ViewedProvider>(context);
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productID);
    bool? isInCart = cartProvider.getCartItems.containsKey(productID);

    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;
    return WillPopScope(
      onWillPop: () async {
        viewedProvider.addProductToViewed(productID: productID);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
              viewedProvider.addProductToViewed(productID: productID);
            },
            child: Icon(
              IconlyLight.arrowLeft2,
              color: Utils(context).color,
            ),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Column(
          children: [
            Flexible(
              flex: 2,
              child: FancyShimmerImage(
                imageUrl: getCurrentProduct.imageUrl,
                width: utils.screenSize.width,
                boxFit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: utils.getTheme
                      ? Theme.of(context).cardColor.withOpacity(0.9)
                      : Colors.white.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextWidget(
                              text: getCurrentProduct.title,
                              color: utils.color,
                              textSize: 25,
                              isTitle: true,
                            ),
                          ),
                          HearthBTN(
                            productID: productID,
                            isInWishlist: isInWishlist,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextWidget(
                            text: '€${usedPrice.toStringAsFixed(2)}',
                            color: utils.greenColor,
                            textSize: 22,
                            isTitle: true,
                          ),
                          TextWidget(
                              text:
                                  '/${getCurrentProduct.isPiece ? 'Piece' : 'KG'}',
                              color: utils.color,
                              textSize: 12),
                          const SizedBox(
                            width: 10,
                          ),
                          Visibility(
                            visible: getCurrentProduct.isOnSale,
                            child: Text(
                              '€${getCurrentProduct.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 15,
                                color: utils.color,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: utils.greenColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextWidget(
                              text: 'Free delivery',
                              color: utils.color,
                              textSize: 20,
                              isTitle: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 40,
                          left: utils.screenSize.width * 0.3,
                          right: utils.screenSize.width * 0.3),
                      child: _quantityController(utils: utils),
                    ),
                    const Spacer(),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: 'Total',
                                    color: utils.orangeColor,
                                    textSize: 20,
                                    isTitle: true,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      TextWidget(
                                        text:
                                            '€${(usedPrice * _currentValue).toStringAsFixed(2)}',
                                        color: utils.color,
                                        textSize: 20,
                                        isTitle: true,
                                      ),
                                      TextWidget(
                                          text:
                                              '/$_currentValue${getCurrentProduct.isPiece ? 'Piece' : 'KG'}',
                                          color: utils.color,
                                          textSize: 16)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Flexible(
                                child: Material(
                              color: utils.greenColor,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
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
                                            productID: productID,
                                            quantity: _currentValue);
                                      },
                                borderRadius: BorderRadius.circular(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextWidget(
                                      text:
                                          isInCart ? 'In cart' : 'Add to Cart',
                                      color: utils.color,
                                      textSize: 18),
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quantityController({required Utils utils}) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            width: 1.5,
            color: utils.getTheme
                ? const Color.fromRGBO(69, 90, 100, 1)
                : const Color.fromRGBO(189, 189, 189, 1)),
      ),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              setState(() {
                _currentValue--;
              });
            },
            child: const Icon(
              Icons.remove,
              size: 40,
            ),
          ),
          const Spacer(),
          Text(
            textAlign: TextAlign.center,
            _currentValue.toString(),
            style: TextStyle(
              fontSize: 36,
              color: utils.color,
            ),
          ),
          const Spacer(),
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              setState(() {
                _currentValue++;
              });
            },
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
