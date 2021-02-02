import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

enum HistoryListItemType { rewardEarned, stampsEarned }

class HistoryListItem extends StatefulWidget {
  HistoryListItem({
    Key key,
    @required this.date,
    @required this.type,
    this.money,
    this.stamps,
  }) : super(key: key);

  final HistoryListItemType type;

  final date;

  final double money;

  final int stamps;

  @override
  _HistoryListItemState createState() => _HistoryListItemState();
}

class _HistoryListItemState extends State<HistoryListItem> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    var width = MediaQuery.of(context).size.width - 60;
    bool isReward = widget.type == HistoryListItemType.rewardEarned;
    return Stack(
      children: [
        Container(
          key: widgetKey,
          width: width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(14))),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isReward ? 'Reward Earned' : 'Stamps Earned',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        widget.date,
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(14))),
              height: oldSize.height,
              width: oldSize.width / 3 + 20,
            ))
      ],
    );
  }

  var widgetKey = GlobalKey();
  Size oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
  }
}
