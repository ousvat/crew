import 'package:Crew/models/home_data.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  HomeData home = HomeData();

  bool get showLoading => home.showLoading;

  set showLoading(bool showLoading) {
    home.showLoading = showLoading;
    notifyListeners();
  }

  int get loadingPercent => home.loadingPercent;

  set loadingPercent(int loadingPercent) {
    home.loadingPercent = loadingPercent;
    notifyListeners();
  }

  int get currentStamps => home.currentStamps;

  set currentStamps(int currentStamps) {
    home.currentStamps = currentStamps;

    if (currentStamps > 6) {
      // TODO: Add a reward in history list
      home.currentStamps = currentStamps % 7;
      // Number of rewards = currentStamps / 7
    }
    notifyListeners();
  }
}
