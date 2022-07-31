import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/widgets/orders_widget.dart';
import 'package:provider/provider.dart';
import '../inner_screens/empty.dart';
import '../provider/dark_theme_provider.dart';
import '../services/utils.dart';
import '../widgets/back_widget.dart';
import '../widgets/text_widget.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = "/OrdersScreen";
  const OrdersScreen({Key? key}) : super(key: key);

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
          text: 'Orders (items)',
          color: utils.color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: isEmpty
          ? const EmptyScreen(
              emptyText: 'You dont have any orders',
              image: 'assets/images/basket.png',
            )
          : ListView.separated(
              itemBuilder: (ctx, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: OrderWidget(),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 2,
                );
              },
              itemCount: 10),
    );
  }
}
