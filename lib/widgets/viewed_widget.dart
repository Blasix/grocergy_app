import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery/inner_screens/product_details.dart';
import 'package:grocery/services/global_methods.dart';
import 'package:grocery/widgets/text_widget.dart';

import '../services/utils.dart';

class ViewedWidget extends StatefulWidget {
  const ViewedWidget({Key? key}) : super(key: key);

  @override
  State<ViewedWidget> createState() => _ViewedWidgetState();
}

class _ViewedWidgetState extends State<ViewedWidget> {
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    final Color color = utils.color;
    return ListTile(
      subtitle: const Text('Price'),
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
      title: TextWidget(text: 'Product', color: color, textSize: 18),
      trailing: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(12),
          color: utils.greenColor,
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
            color: utils.color,
          ),
        ),
      ),
    );
  }
}
