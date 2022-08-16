import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery/providers/cart_provider.dart';
import 'package:grocery/providers/wishlist_provider.dart';
import 'package:grocery/widgets/price_widget.dart';
import 'package:grocery/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../inner_screens/product_details.dart';
import '../models/products_model.dart';
import '../services/utils.dart';
import 'heart_btn.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({Key? key}) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  int _currentValue = 1;
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.id);
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: utils.getTheme
            ? Theme.of(context).cardColor.withOpacity(0.9)
            : Colors.white.withOpacity(0.9),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Column(children: [
              Flexible(
                flex: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FancyShimmerImage(
                    imageUrl: productModel.imageUrl,
                    height: 130,
                    width: 130,
                    boxFit: BoxFit.contain,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: TextWidget(
                      maxLines: 1,
                      text: productModel.title,
                      color: utils.color,
                      textSize: 20,
                      isTitle: true,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: HearthBTN(
                      productID: productModel.id,
                      isInWishlist: isInWishlist,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: PriceWidget(
                      isOnSale: productModel.isOnSale,
                      price: productModel.price,
                      salePrice: productModel.salePrice,
                      textPrice: _currentValue.toString(),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                      child: _quantityController(
                          utils: utils,
                          indicator: productModel.isPiece ? 'p' : 'kg'))
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: isInCart
                      ? null
                      : () {
                          cartProvider.addProductsToCart(
                            productID: productModel.id,
                            quantity: _currentValue,
                          );
                        },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      utils.getTheme
                          ? Theme.of(context).cardColor.withOpacity(0.9)
                          : Colors.white.withOpacity(0.9),
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  child: TextWidget(
                    text: isInCart ? 'In cart' : 'Add to Cart',
                    color: utils.color,
                    textSize: 20,
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget _quantityController(
      {required Utils utils, required String indicator}) {
    return Container(
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
              size: 20,
            ),
          ),
          const Spacer(),
          Text(
            textScaleFactor: 1,
            maxLines: 1,
            textAlign: TextAlign.center,
            _currentValue.toString(),
            style: TextStyle(
              fontSize: 18,
              color: utils.color,
            ),
          ),
          Text(
            maxLines: 1,
            textAlign: TextAlign.end,
            indicator,
            style: TextStyle(
              fontSize: 12,
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
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
