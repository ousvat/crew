import 'package:Crew/theme/icons/crew_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({Key key, this.iconColor, @required this.logoSize, this.textColor})
      : super(key: key);

  final Color iconColor;

  final Color textColor;

  final double logoSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Icon(
          CrewIcons.crosshairs,
          color: iconColor,
          size: logoSize,
        ),
        Positioned(
          left: logoSize + 5,
          top: 0,
          child: Text('CREW',
              style: TextStyle(
                fontFamily: GoogleFonts.bebasNeue().fontFamily,
                color: textColor,
                fontSize: logoSize,
              )),
        )
      ],
    );
  }
}
