import 'package:flutter/cupertino.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../services/utils.dart';

class HearthBTN extends StatelessWidget {
  const HearthBTN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    return GestureDetector(
      onTap: () {},
      child: Icon(
        IconlyLight.heart,
        size: 22,
        color: utils.color,
      ),
    );
  }
}
