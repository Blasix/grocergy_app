import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:grocery/constants/theme_data.dart';
import 'package:grocery/widgets/price_widget.dart';
import 'package:grocery/widgets/text_widget.dart';

import '../services/utils.dart';
import 'heart_btn.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({Key? key}) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  String _currentValue = '1';
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
    final utils = Utils(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: utils.getTheme
            ? Theme.of(context).cardColor.withOpacity(0.9)
            : Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Column(children: [
              FancyShimmerImage(
                imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                height: utils.screenSize.width * 0.22,
                width: utils.screenSize.width * 0.22,
                boxFit: BoxFit.fill,
              ),
              Row(
                children: [
                  TextWidget(
                    text: 'Product',
                    color: utils.color,
                    textSize: 20,
                    isTitle: true,
                  ),
                  const Spacer(),
                  const HearthBTN()
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PriceWidget(
                    isOnSale: false,
                    price: 3.99,
                    salePrice: 2.99,
                    textPrice: _currentValue,
                  ),
                  const Spacer(),
                  CustomNumberPicker(
                    customAddButton: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.add,
                          size: 15,
                        )),
                    customMinusButton: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.remove,
                          size: 15,
                        )),
                    initialValue: 1,
                    maxValue: 99,
                    minValue: 1,
                    step: 1,
                    onValue: (value) {
                      setState(() {
                        _currentValue = value.toString();
                      });
                    },
                  )
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
                          : Colors.white,
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
}
