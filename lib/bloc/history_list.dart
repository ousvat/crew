import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Crew/models/history_data.dart';

class HistoryList extends Cubit<List<HistoryData>> {
  HistoryList() : super([]);

  void add(element) {
    List<HistoryData> l = [...state, element];
    print(state);
    emit(l);
  }
}
