import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/widgets/feed_items.dart';

import '../services/utils.dart';
import '../widgets/text_widget.dart';

class FeedsScreen extends StatefulWidget {
  static const routeName = "/FeedsScreen";
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            color: utils.color,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'All Products',
          color: utils.color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: kBottomNavigationBarHeight,
                child: TextField(
                  maxLines: 1,
                  focusNode: _searchTextFocusNode,
                  controller: _searchTextController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: utils.blueColor,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: utils.color,
                        width: 1,
                      ),
                    ),
                    label: const Icon(Icons.search),
                    hintText: 'Search Product',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _searchTextController.clear();
                        _searchTextFocusNode.unfocus();
                      },
                      icon: Icon(Icons.close,
                          color: _searchTextFocusNode.hasFocus
                              ? utils.redColor
                              : utils.color),
                    ),
                  ),
                  cursorColor: utils.blueColor,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              // crossAxisSpacing: 10,
              childAspectRatio:
                  utils.screenSize.width / (utils.screenSize.height * 0.57),
              children: List.generate(16, (index) {
                return const FeedsWidget();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
