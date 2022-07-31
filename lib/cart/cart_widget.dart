import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery/widgets/heart_btn.dart';
import 'package:grocery/widgets/text_widget.dart';

import '../services/utils.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int _currentValue = 1;
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
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: utils.getTheme
                      ? Theme.of(context).cardColor.withOpacity(0.9)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FancyShimmerImage(
                        imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                        height: utils.screenSize.width * 0.25,
                        width: utils.screenSize.width * 0.25,
                        boxFit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Product',
                          color: utils.color,
                          textSize: 22,
                          isTitle: true,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        _quantityController(utils: utils)
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
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
                          TextWidget(
                            text: 'price',
                            color: utils.color,
                            textSize: 22,
                            maxLines: 1,
                          )
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
              setState(() {
                _currentValue++;
              });
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
