import 'package:flutter/cupertino.dart';
import 'package:grocery/widgets/text_widget.dart';

import '../services/utils.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    return FittedBox(
      child: Row(
        children: [
          TextWidget(
            text: 'Price\$',
            color: utils.greenColor,
            textSize: 22,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            'Price\$',
            style: TextStyle(
              fontSize: 15,
              color: utils.color,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
