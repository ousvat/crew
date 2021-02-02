import 'package:Crew/theme/icons/crew_icons_icons.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CircleWithStamp extends StatefulWidget {
  CircleWithStamp({Key key, @required this.haveStamp}) : super(key: key);

  final bool haveStamp;
  @override
  _CircleWithStampState createState() => _CircleWithStampState();
}

class _CircleWithStampState extends State<CircleWithStamp> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    width = width / 6;
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          width: width,
          height: width,
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
        ),
        widget.haveStamp
            ? Positioned(
                top: _randomDouble(),
                left: _randomDouble(),
                child: Icon(
                  CrewIcons.crosshairs,
                  size: width - 5,
                  color: Theme.of(context).accentColor,
                ),
              )
            : SizedBox(),
      ],
    );
  }

  double _randomDouble() {
    var random = Random();
    var negative = random.nextBool();
    if (negative)
      return -random.nextDouble() * 5;
    else
      return random.nextDouble() * 7;
  }
}
