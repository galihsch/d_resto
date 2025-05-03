import 'package:flutter/material.dart';

class ScrollProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  bool _isScrolled = false;

  bool get isScrolled => _isScrolled;

  ScrollProvider() {
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset > 20 && !_isScrolled) {
      _isScrolled = true;
      notifyListeners();
    } else if (scrollController.offset <= 20 && _isScrolled) {
      _isScrolled = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }
}
