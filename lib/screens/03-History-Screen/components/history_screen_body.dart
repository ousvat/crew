import 'package:Crew/screens/03-History-Screen/components/history_list_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryScreenBody extends StatefulWidget {
  const HistoryScreenBody({Key key}) : super(key: key);

  @override
  _HistoryScreenBodyState createState() => _HistoryScreenBodyState();
}

class _HistoryScreenBodyState extends State<HistoryScreenBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        // physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 30),
          /**
           * Here the list
           */
          ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(right: 30, left: 30),
            children: [
              SizedBox(height: 120),
              HistoryListItem(
                type: HistoryListItemType.rewardEarned,
                date: DateFormat('dd/MM/yy').format(DateTime.now()),
              ),
              SizedBox(height: 20),
              HistoryListItem(
                type: HistoryListItemType.stampsEarned,
                date: DateFormat('dd/MM/yy').format(DateTime.now()),
                stamps: 1,
                money: 156.5,
              ),
              SizedBox(height: 20),
              HistoryListItem(
                type: HistoryListItemType.stampsEarned,
                date: DateFormat('dd/MM/yy').format(DateTime.now()),
                stamps: 3,
                money: 23.3,
              ),
              SizedBox(height: 30),
              HistoryListItem(
                type: HistoryListItemType.rewardEarned,
                date: DateFormat('dd/MM/yy').format(DateTime.now()),
              ),
              SizedBox(height: 20),
              HistoryListItem(
                type: HistoryListItemType.stampsEarned,
                date: DateFormat('dd/MM/yy').format(DateTime.now()),
                stamps: 1,
                money: 156.5,
              ),
              SizedBox(height: 20),
              HistoryListItem(
                type: HistoryListItemType.stampsEarned,
                date: DateFormat('dd/MM/yy').format(DateTime.now()),
                stamps: 3,
                money: 23.3,
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
