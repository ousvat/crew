import 'package:Crew/screens/03-History-Screen/components/history_list_item.dart';
import 'package:flutter/material.dart';

class HistoryScreenBody extends StatefulWidget {
  const HistoryScreenBody({Key key}) : super(key: key);

  @override
  _HistoryScreenBodyState createState() => _HistoryScreenBodyState();
}

class _HistoryScreenBodyState extends State<HistoryScreenBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
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
          SizedBox(height: 30),
          /**
           * Here the list
           */
          HistoryListItem(type: HistoryListItemType.rewardEarned,date: 'dsa',),
          SizedBox(height: 30),
          Text(
            'Start of activity',
            style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
