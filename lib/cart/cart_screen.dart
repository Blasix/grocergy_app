import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../services/utils.dart';
import '../widgets/text_widget.dart';
import 'cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Cart (items)',
          color: utils.color,
          textSize: 24,
          isTitle: true,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                IconlyBroken.delete,
                color: utils.color,
              )),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: utils.screenSize.height * 0.08,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: [
                  Material(
                    color: utils.blueColor,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWidget(
                          text: 'Order Now',
                          color: utils.color,
                          textSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextWidget(
                      text: 'Total: price', color: utils.color, textSize: 22)
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (ctx, index) {
                  return const CartWidget();
                }),
          ),
        ],
      ),
    );
  }
}
