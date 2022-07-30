import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery/widgets/text_widget.dart';

import '../services/utils.dart';
import 'heart_btn.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({Key? key}) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
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
              Row(
                children: [
                  TextWidget(
                      text: 'Price\$', color: utils.greenColor, textSize: 20),
                  const Spacer(),
                  Flexible(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 6,
                        ),
                        Flexible(
                            child: TextFormField(
                          controller: _quantityTextController,
                          key: const ValueKey('10'),
                          style: TextStyle(color: utils.color, fontSize: 18),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          enabled: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                          ],
                        )),
                        const SizedBox(
                          width: 5,
                        ),
                        FittedBox(
                          child: TextWidget(
                            text: 'KG',
                            color: utils.color,
                            textSize: 16,
                            isTitle: true,
                          ),
                        ),
                      ],
                    ),
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
