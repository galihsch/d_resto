import 'package:flutter/foundation.dart';

class UIProvider extends ChangeNotifier {
  bool _isScrolled = false;
  bool get isScrolled => _isScrolled;

  void setScrollState(bool isScrolled) {
    if (_isScrolled != isScrolled) {
      _isScrolled = isScrolled;
      notifyListeners();
    }
  }
}
