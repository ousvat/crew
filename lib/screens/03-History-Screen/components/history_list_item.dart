import 'package:Crew/models/history_data.dart';
import 'package:Crew/theme/icons/crew_icons_icons.dart';
import 'package:Crew/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HistoryListItem extends StatefulWidget {
  HistoryListItem({Key key, @required this.historyData}) : super(key: key);

  final HistoryData historyData;

  @override
  _HistoryListItemState createState() => _HistoryListItemState();
}

class _HistoryListItemState extends State<HistoryListItem> {
  @override
  void initState() {
    super.initState();
    oldSize = new Size(75, 75);
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    var width = MediaQuery.of(context).size.width - 60;
    bool isReward = widget.historyData.type == HistoryListItemType.rewardEarned;
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
                        widget.historyData.date,
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    isReward
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(
                              '\$${widget.historyData.money.toString()}',
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
                  color: isReward
                      ? Theme.of(context).accentColor.withOpacity(.5)
                      : Color(0xFF80A0C6),
                  borderRadius: BorderRadius.all(Radius.circular(14))),
              height: oldSize.height,
              width: oldSize.width / 3 + 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    isReward ? CrewIcons.gift : CrewIcons.crosshairs,
                    color: Colors.white,
                    size: oldSize.height / 2 - 15,
                  ),
                  isReward
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            '+${widget.historyData.stamps}' +
                                (widget.historyData.stamps > 1 ? ' stamps' : ' stamp'),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                ],
              ),
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

    setState(() {
      oldSize = newSize;
    });
  }
}
