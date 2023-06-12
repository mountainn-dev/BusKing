import 'package:flutter/foundation.dart';

class CardViewModel with ChangeNotifier {
  var _isClicked = false;

  void clicked() {
    _isClicked = true;
    notifyListeners();
  }
}