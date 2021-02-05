import 'dart:async';
import 'dart:io' as Io;
import 'dart:convert';
import 'dart:math';

import 'package:Crew/components/crew_alert_dialog.dart';
import 'package:Crew/models/scan_result.dart';
import 'package:Crew/providers/app_data_provider.dart';
import 'package:Crew/theme/icons/crew_icons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googleapis/vision/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:provider/provider.dart';

class CredentialsProvider {
  CredentialsProvider();

  Future<ServiceAccountCredentials> get _credentials async {
    String _file = await rootBundle.loadString('assets/data/credentials.json');
    return ServiceAccountCredentials.fromJson(_file);
  }

  Future<AutoRefreshingAuthClient> get client async {
    AutoRefreshingAuthClient _client = await clientViaServiceAccount(
        await _credentials, [VisionApi.CloudVisionScope]);
    return _client;
  }
}

class AnalyzePhoto {
  var _client = CredentialsProvider().client;

  Future<void> getResponse(String image, BuildContext context) async {
    Provider.of<AppData>(context, listen: false).showLoading = true;
    Provider.of<AppData>(context, listen: false).loadingPercent = 10;

    /** Processing the image */
    final bytes = Io.File(image).readAsBytesSync();

    String img64 = base64Encode(bytes);
    var _vision = VisionApi(await _client);
    var _api = _vision.images;
    var _response = await _api.annotate(BatchAnnotateImagesRequest.fromJson({
      "requests": [
        {
          "image": {"content": img64},
          "features": [
            {"type": "TEXT_DETECTION"}
          ]
        }
      ]
    }));

    /** Visual feedback */
    Timer(Duration(milliseconds: 500), () {
      Provider.of<AppData>(context, listen: false).loadingPercent = 75;
    });

    /** Get the maximum price from results */
    var doubleRE = RegExp(r"\d+[.]\d{2} ");
    var text;
    if (_response.responses[0].fullTextAnnotation != null)
      text = _response.responses[0].fullTextAnnotation.text;
    else {
      Provider.of<AppData>(context, listen: false).loadingPercent = 0;
      Provider.of<AppData>(context, listen: false).showLoading = false;
      _showCongratsDialog(context, 0, 0);
      return null;
    }
    text = text.replaceAll(RegExp(r'[a-zA-Z]'), '');
    text = text.replaceAll(RegExp(r'(\r\n|\r|\n)'), ' ');
    print(text); //TODO: Delete prints after implementation
    var numbers =
        doubleRE.allMatches(text).map((m) => double.parse(m[0])).toList();
    print(numbers);

    var price = numbers.reduce(max) ?? 0;
    var stamps = (price / 20).truncate();

    /** Show feedback dialog */
    Timer(Duration(milliseconds: 1700), () {
      Provider.of<AppData>(context, listen: false).loadingPercent = 100;
      _showCongratsDialog(context, stamps, price);
    });
  }

  void _showCongratsDialog(BuildContext context, int stamps, double money) {
    showDialog(
        context: context,
        child: CrewAlertDialog(
          heightRegulation: -30,
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              stamps > 0 ? 'Congratulations!' : 'Sorry!',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Theme.of(context).primaryColor,
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontSize: 26,
              ),
            ),
          ),
          title: Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
              ),
              Positioned(
                top: 7.5,
                left: 7.5,
                child: Icon(
                  CrewIcons.crosshairs,
                  size: 45,
                  color: Theme.of(context).accentColor,
                ),
              )
            ],
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
            child: Text(
              stamps > 0
                  ? 'You earned $stamps stamps from a \$$money purchase.'
                  : 'Your purchase is lower than 20\$.',
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Theme.of(context).primaryColor,
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          actions: Container(
            width: double.maxFinite,
            child: FlatButton(
              child: Text(
                stamps > 0 ? 'YAY' : 'OH... OK',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onPressed: () {
                Provider.of<AppData>(context, listen: false).showLoading =
                    false;
                Provider.of<AppData>(context, listen: false).loadingPercent = 0;
                Provider.of<AppData>(context, listen: false).currentStamps +=
                    stamps;
                Navigator.pop(context);
              },
            ),
          ),
        ));
  }
}
