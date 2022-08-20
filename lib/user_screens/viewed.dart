import 'package:flutter/material.dart';
import 'package:grocery/providers/viewed_provider.dart';
import 'package:grocery/widgets/viewed_widget.dart';
import 'package:provider/provider.dart';
import '../inner_screens/empty.dart';
import '../services/utils.dart';
import '../widgets/back_widget.dart';
import '../widgets/text_widget.dart';

class ViewedScreen extends StatelessWidget {
  static const routeName = "/ViewedScreen";
  const ViewedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewedProvider = Provider.of<ViewedProvider>(context);
    final viewedItemList = viewedProvider.getViewedItems.values.toList();
    final utils = Utils(context);
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Viewed products',
          color: utils.color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: viewedItemList.isEmpty
          ? const EmptyScreen(
              emptyText: 'You have not viewed any items yet',
              image: 'assets/images/history.png',
            )
          : ListView.separated(
              itemBuilder: (ctx, index) {
                return ChangeNotifierProvider.value(
                  value: viewedItemList[index],
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    child: ViewedWidget(),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 2,
                );
              },
              itemCount: viewedItemList.length),
    );
  }
}
