import 'package:flutter/foundation.dart';

class SearchProvider with ChangeNotifier {
  bool _isInitialState = true;

  bool get isInitialState => _isInitialState;

  void setSearchState(bool value) {
    _isInitialState = value;
    notifyListeners();
  }

  void resetSearch() {
    _isInitialState = true;
    notifyListeners();
  }
}
