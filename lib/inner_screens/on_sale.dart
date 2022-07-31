import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/widgets/on_sale_widget.dart';

import '../services/utils.dart';
import '../widgets/back_widget.dart';
import '../widgets/text_widget.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;
    final utils = Utils(context);
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Products on sale',
          color: utils.color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/box.png',
                    scale: 2,
                  ),
                  Text(
                    'No Products On Sale yet!\nStay tuned',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: utils.color,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              // crossAxisSpacing: 10,
              childAspectRatio: 40 / 34,
              children: List.generate(16, (index) {
                return const OnSaleWidget();
              }),
            ),
    );
  }
}
