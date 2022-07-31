import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/inner_screens/product_details.dart';
import 'package:grocery/services/global_methods.dart';
import 'package:grocery/services/utils.dart';
import 'package:grocery/widgets/heart_btn.dart';
import 'package:grocery/widgets/text_widget.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).screenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          GlobalMethods.navigateTo(
              ctx: context, routeName: ProductDetails.routeName);
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
                    FancyShimmerImage(
                      imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                      height: size.width * 0.23,
                      width: size.width * 0.23,
                      boxFit: BoxFit.fill,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                IconlyLight.bag2,
                                color: color,
                              ),
                            ),
                            const HearthBTN(),
                          ],
                        ),
                        TextWidget(
                          text: 'Price',
                          color: color,
                          textSize: 20,
                          isTitle: true,
                        ),
                        TextWidget(text: '/kg', color: color, textSize: 16),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: TextWidget(
                    text: 'Product',
                    color: color,
                    textSize: 20,
                    isTitle: true,
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
