import 'package:flutter/material.dart';
import 'package:grocery/inner_screens/cat_screen.dart';
import 'package:grocery/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget(
      {Key? key,
      required this.catText,
      required this.color,
      required this.imgPath})
      : super(key: key);
  final String catText, imgPath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CategoryScreen.routeName,
            arguments: catText);
      },
      child: Container(
        decoration: BoxDecoration(
          color: this.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: this.color.withOpacity(0.7),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: screenWidth * 0.03,
            ),
            Container(
              height: screenWidth * 0.3,
              width: screenWidth * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(imgPath),
                fit: BoxFit.fill,
              )),
            ),
            TextWidget(
              text: catText,
              color: color,
              textSize: 20,
              isTitle: true,
            )
          ],
        ),
      ),
    );
  }
}
