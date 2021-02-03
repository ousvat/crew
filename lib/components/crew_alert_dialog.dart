import 'dart:ui';
import 'package:flutter/material.dart';

class CrewAlertDialog extends StatelessWidget {
  const CrewAlertDialog(
      {Key key,
      this.actions,
      this.content,
      this.subtitle,
      this.title,
      this.heightRegulation})
      : super(key: key);

  final Widget title;

  final Widget subtitle;

  final Widget content;

  final Widget actions;

  final double heightRegulation;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white.withOpacity(.2),
      width: size.width,
      height: size.width,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Center(
          child: Container(
            height: size.height / 2 + (heightRegulation ?? 0),
            width: size.width - 60,
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  title ?? SizedBox(),
                  subtitle ?? SizedBox(),
                  content ?? SizedBox(),
                  Expanded(child: SizedBox()),
                  actions ?? SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
