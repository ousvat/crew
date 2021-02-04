import 'dart:io' as Io;
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:googleapis/vision/v1.dart';
import 'package:googleapis_auth/auth_io.dart';

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

  Future<void> getResponse(String image) async {
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
    print('Response:');
    print(_response.toString());

    var doubleRE = RegExp(r"\d+[.]\d{2} ");
    var text = _response.responses[0].fullTextAnnotation.text;
    text = text.replaceAll(RegExp(r'[a-zA-Z]'), '');
    print(text); //TODO: Delete prints after implementation
    var numbers =
        doubleRE.allMatches(text).map((m) => double.parse(m[0])).toList();
    print(numbers);
    print(numbers.runtimeType);
  }
}
