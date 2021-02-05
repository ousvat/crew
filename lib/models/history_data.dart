import 'package:Crew/utils/enums.dart';
import 'package:intl/intl.dart';

class HistoryData {
  HistoryData({date, this.type, this.stamps, this.money}) {
    this.date = date;
  }

  var _date;

  get date => _date;

  set date(date) {
    _date = DateFormat('dd/MM/yy').format(date);
  }

  int stamps;

  HistoryListItemType type;

  double money;
}
