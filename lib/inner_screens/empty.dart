import 'package:flutter/material.dart';
import 'package:grocery/inner_screens/feeds.dart';
import 'package:grocery/services/global_methods.dart';
import 'package:grocery/services/utils.dart';
import 'package:grocery/widgets/text_widget.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key, required this.emptyText, required this.image})
      : super(key: key);
  final String emptyText, image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Utils(context).screenSize.height * 0.06,
            ),
            Image.asset(
              image,
              width: double.infinity,
              height: Utils(context).screenSize.height * 0.4,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Whoops!',
              style: TextStyle(
                color: Utils(context).color,
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              text: emptyText,
              color: Utils(context).color,
              textSize: 20,
              isTitle: true,
            ),
            SizedBox(
              height: Utils(context).screenSize.height * 0.08,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    primary: Utils(context).blueColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10)),
                onPressed: () {
                  GlobalMethods.navigateTo(
                      ctx: context, routeName: FeedsScreen.routeName);
                },
                child: TextWidget(
                  text: 'Browse Products',
                  color: Utils(context).color,
                  textSize: 20,
                  isTitle: true,
                ))
          ],
        ),
      )),
    );
  }
}
