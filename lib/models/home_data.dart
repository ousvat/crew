import 'package:flutter/cupertino.dart';

class HomeData extends ChangeNotifier {
  bool _showLoading = false;

  bool get showLoading => _showLoading;

  set showLoading(bool showLoading) {
    _showLoading = showLoading;
    notifyListeners();
  }

  int _currentStamps = 0;

  int get currentStamps => _currentStamps;

  set currentStamps(int currentStamps) {
    _currentStamps = currentStamps;
    notifyListeners();
  }

  int _loadingPercent = 0;

  int get loadingPercent => _loadingPercent;

  set loadingPercent(int loadingPercent) {
    _loadingPercent = loadingPercent;
    notifyListeners();
  }
}
