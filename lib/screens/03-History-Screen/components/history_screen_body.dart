import 'package:Crew/providers/app_data_provider.dart';
import 'package:Crew/screens/03-History-Screen/components/history_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreenBody extends StatefulWidget {
  const HistoryScreenBody({Key key}) : super(key: key);

  @override
  _HistoryScreenBodyState createState() => _HistoryScreenBodyState();
}

class _HistoryScreenBodyState extends State<HistoryScreenBody> {
  @override
  Widget build(BuildContext context) {
    var list = Provider.of<AppData>(context).historyList;
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(height: 30),
          ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(right: 30, left: 30),
            children: [
              SizedBox(height: 120),
              ListView.separated(
                itemCount: list.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return HistoryListItem(historyData: list[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20);
                },
              ),
              SizedBox(height: 30),
              Text(
                'Start of activity',
                style: TextStyle(
                  color: Theme.of(context).disabledColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
            ],
          ),
          Container(
            margin: EdgeInsets.all(0),
            width: double.infinity,
            height: 100,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 35, left: 25),
              child: Text(
                'History',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
