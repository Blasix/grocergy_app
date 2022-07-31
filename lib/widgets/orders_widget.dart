import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery/inner_screens/product_details.dart';
import 'package:grocery/services/global_methods.dart';
import 'package:grocery/widgets/text_widget.dart';

import '../services/utils.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    final Color color = utils.color;
    return ListTile(
      subtitle: const Text('Paid: price'),
      onTap: () {
        GlobalMethods.navigateTo(
            ctx: context, routeName: ProductDetails.routeName);
      },
      leading: FancyShimmerImage(
        imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
        height: 58,
        width: 58,
        boxFit: BoxFit.fill,
      ),
      title: TextWidget(text: 'Product xQty', color: color, textSize: 18),
      trailing: TextWidget(text: 'date', color: color, textSize: 18),
    );
  }
}
