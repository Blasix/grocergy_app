import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery/models/cart_model.dart';
import 'package:grocery/providers/product_provider.dart';
import 'package:grocery/widgets/heart_btn.dart';
import 'package:grocery/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../inner_screens/product_details.dart';
import '../providers/cart_provider.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key, required this.q}) : super(key: key);
  final int q;
  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  late int _currentValue;

  @override
  void initState() {
    _currentValue = widget.q;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartModel = Provider.of<CartModel>(context);
    final getCurrentProduct = productProvider.findProdById(cartModel.productID);
    final cartProvider = Provider.of<CartProvider>(context);
    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: cartModel.productID);
      },
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: utils.getTheme
                      ? Theme.of(context).cardColor.withOpacity(0.9)
                      : Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FancyShimmerImage(
                        imageUrl: getCurrentProduct.imageUrl,
                        height: utils.screenSize.width * 0.25,
                        width: utils.screenSize.width * 0.25,
                        boxFit: BoxFit.contain,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: getCurrentProduct.title,
                          color: utils.color,
                          textSize: 22,
                          isTitle: true,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        _quantityController(
                            utils: utils,
                            cartModel: cartModel,
                            cartProvider: cartProvider)
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              cartProvider.removeOneItem(cartModel.productID);
                            },
                            child: Icon(
                              CupertinoIcons.cart_badge_minus,
                              color: utils.redColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          const HearthBTN(),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              TextWidget(
                                text: '€${(usedPrice).toStringAsFixed(2)}',
                                color: utils.color,
                                textSize: 22,
                                maxLines: 1,
                              ),
                              // TextWidget(
                              //     text:
                              //         '/$_currentValue${getCurrentProduct.isPiece ? 'Piece' : 'KG'}',
                              //     color: utils.color,
                              //     textSize: 16)
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _quantityController({
    required Utils utils,
    required cartModel,
    required cartProvider,
  }) {
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
              if (_currentValue == 1) {
                return;
              } else {
                setState(() {
                  _currentValue--;
                });
                cartProvider.reduceQuantityByOne(cartModel.productID);
              }
            },
            child: const Icon(
              Icons.remove,
              size: 26,
            ),
          ),
          SizedBox(
            width: 28,
            child: Text(
              textAlign: TextAlign.center,
              _currentValue.toString(),
              style: TextStyle(
                fontSize: 24,
                color: utils.color,
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              if (_currentValue == 99) {
                return;
              } else {
                setState(() {
                  _currentValue++;
                });
                cartProvider.increaseQuantityByOne(cartModel.productID);
              }
            },
            child: const Icon(
              Icons.add,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}
