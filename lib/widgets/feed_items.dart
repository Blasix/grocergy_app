import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery/services/global_methods.dart';
import 'package:grocery/widgets/price_widget.dart';
import 'package:grocery/widgets/text_widget.dart';

import '../inner_screens/product_details.dart';
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
            GlobalMethods.navigateTo(
                ctx: context, routeName: ProductDetails.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Column(children: [
              Flexible(
                flex: 50,
                child: FancyShimmerImage(
                  imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                  height: 130,
                  width: 130,
                  boxFit: BoxFit.fill,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: TextWidget(
                      maxLines: 1,
                      text: 'Product',
                      color: utils.color,
                      textSize: 20,
                      isTitle: true,
                    ),
                  ),
                  const Flexible(
                    flex: 1,
                    child: HearthBTN(),
                  )
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  PriceWidget(
                    isOnSale: false,
                    price: 3.99,
                    salePrice: 2.99,
                    textPrice: _currentValue.toString(),
                  ),
                  const Spacer(),
                  _quantityController(utils: utils)
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
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
                    text: 'Add to Cart',
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

  Widget _quantityController({required Utils utils}) {
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
            child: const Icon(Icons.remove),
          ),
          SizedBox(
            width: 24,
            child: Text(
              textAlign: TextAlign.center,
              _currentValue.toString(),
              style: TextStyle(
                fontSize: 18,
                color: utils.color,
              ),
            ),
          ),
          // const SizedBox(
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              setState(() {
                _currentValue++;
              });
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
