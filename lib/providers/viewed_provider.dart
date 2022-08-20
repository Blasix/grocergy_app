import 'package:flutter/cupertino.dart';
import 'package:grocery/models/viewed_model.dart';

class ViewedProvider with ChangeNotifier {
  final Map<String, ViewedModel> _viewedItems = {};

  Map<String, ViewedModel> get getViewedItems {
    return _viewedItems;
  }

  void addProductToViewed({required String productID}) {
    _viewedItems.putIfAbsent(
      productID,
      () => ViewedModel(ID: DateTime.now().toString(), productID: productID),
    );
    notifyListeners();
  }

  // void clearViewed() {
  //   _viewedItems.clear();
  //   notifyListeners();
  // }
}
