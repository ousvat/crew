import 'package:Crew/models/history_data.dart';
import 'package:Crew/models/home_data.dart';
import 'package:Crew/screens/03-History-Screen/components/history_list_item.dart';
import 'package:Crew/utils/enums.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  HomeData home = HomeData();

  List<HistoryData> _historyList = [
    HistoryData(
      date: DateTime.now(),
      type: HistoryListItemType.rewardEarned,
    ),
    HistoryData(
        date: DateTime.now(),
        money: 26.3,
        stamps: 1,
        type: HistoryListItemType.stampsEarned),
    HistoryData(
        date: DateTime.now(),
        money: 122.43,
        stamps: 6,
        type: HistoryListItemType.stampsEarned),
  ];

  List<HistoryData> get historyList => _historyList;

  set historyList(List<HistoryData> historyList) {
    _historyList = historyList;
    notifyListeners();
  }

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
      var rewards = (home.currentStamps / 7).truncate();
      for (int i = 0; i < rewards; i++)
        this.historyList.insert(
            0,
            HistoryData(
              type: HistoryListItemType.rewardEarned,
              date: DateTime.now(),
            ));
      home.currentStamps = currentStamps % 7;
    }
    notifyListeners();
  }
}
